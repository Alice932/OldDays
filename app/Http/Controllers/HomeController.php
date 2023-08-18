<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Display the home page.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('home.index');
    }

    /**
     * Handle a form submission.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function submitForm(Request $request)
    {
        // Handle the form submission logic here

        // Example: Retrieve form data
        $name = $request->input('name');
        $email = $request->input('email');

        // Example: Save form data to database
        // $user = new User();
        // $user->name = $name;
        // $user->email = $email;
        // $user->save();

        // Redirect back to the home page
        return redirect()->route('home')->with('success', 'Form submitted successfully!');
    }

    public function about()
    {
        return view('home.about');
    }

}
