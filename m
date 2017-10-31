From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mmc: vub300: Use common code in
 __download_offload_pseudocode()
Date: Tue, 31 Oct 2017 11:45:52 +0300
Message-ID: <20171031084552.mvvn73pfew4rebsd@mwanda>
References: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
 <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com>
 <20171030121508.zfnsvpsrt25prhr4@mwanda>
 <CAPDyKFqaaX3i5wLu-aORRB765Kjac705384UM4nCbV8n1Kfc3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqaaX3i5wLu-aORRB765Kjac705384UM4nCbV8n1Kfc3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Tony Olech <tony.olech@elandigitalsystems.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 30, 2017 at 02:03:13PM +0100, Ulf Hansson wrote:
> On 30 October 2017 at 13:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Mon, Oct 30, 2017 at 12:40:39PM +0100, Ulf Hansson wrote:
> >> On 27 October 2017 at 21:31, SF Markus Elfring
> >> <elfring@users.sourceforge.net> wrote:
> >> > From: Markus Elfring <elfring@users.sourceforge.net>
> >> > Date: Fri, 27 Oct 2017 21:21:40 +0200
> >> >
> >> > Add a jump target so that a specific string copy operation is stored
> >> > only once at the end of this function implementation.
> >> > Replace two calls of the function "strncpy" by goto statements.
> >> >
> >> > This issue was detected by using the Coccinelle software.
> >> >
> >> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >>
> >> Thanks, applied for next!
> >>
> >
> > What's the advantage of this patch?  The new code seems more complicated
> > to me and GCC automatically reuses duplicate constant strings so there
> > is no memory savings.
> 
> It looked to me that the error path got a bit cleaner. However, I
> guess it's matter of taste.
> 
> If you insist, I can drop it.

I'm on the kernel-janitors list so I am CC'd on all of Markus's patches.
It's not my code and I'm tired of being the anti-Markus guy so this
patch is fine.  Markus has a tool that finds duplicate strings and he
uses gotos to avoid them.  I don't think duplicate strings are a problem
or that it's a good idea to send over a hundred patches using this
method.  But many people have explained that to Markus already and
that's not the bigger picture which is about error handling and labels.

What I like are labels that are necessary and self explanatory.  Things
like "goto unlock" are a good example, because we know we need to unlock
and the goto tells us what the label does.  Or here is another example:

	foo = alloc_foo();
	if (!foo)
		return -ENOMEM;

	bar = alloc_bar();
	if (!foo) {
		err = -ENOMEM;
		goto free_foo;
	}

>From reading the code, you know that you have to free foo and the label
name is clear so you literally don't need to scroll down to the bottom
of the function when you're reading this code.  A bad label is like
this:

	foo = alloc_foo();
	if (!foo)
		goto err;

You're reading along and you're like "what happens at the err" label?
So then you have to scroll down to the bottom and read the code, then
you have to think about how the variables line up with the variables
in the above code, then you have to scroll back and find your place
again and by that point you've forgotten what you were doing when you
started.

regards,
dan carpenter
