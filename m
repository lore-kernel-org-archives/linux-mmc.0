From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Fri, 09 Sep 2016 18:44:21 +0530
Message-ID: <1473426861.9415.2.camel@researchut.com>
References: <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
         <Pine.LNX.4.44L0.1609071630350.2115-100000@iolanthe.rowland.org>
         <CAPDyKFr0vEaEbsoPm6YwJD1JOQc=YR=zwi4T6Rr3gCQ4StNuvg@mail.gmail.com>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFr0vEaEbsoPm6YwJD1JOQc=YR=zwi4T6Rr3gCQ4StNuvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, 2016-09-09 at 12:54 +0200, Ulf Hansson wrote:
> This affects the way the core calls the host driver's ->set_ios()
> callback. Earlier it was invoked first to do power off then power up.
> With this change it starts with power up instead.
> I wanted to try this because I suspected the initial state could be wrong.
> 
> So here are some other ideas on how to move forward.
> 1. Run with CONFIG_PM unset to see if we can reproduce the problem.
> 2. Revert back the state in the mmc core we had in 3.16 around how it
> deals with runtime PM for host devices. That's actually very easy as
> we only need to remove the pm_runtime_put|get() calls in
> mmc_claim|release_host().
> 
> Ritesh, can you try these options?
> 

Yes. I can try the above ones now. I'm building the kernel for it.


> Neither of the above will actually solve the problem, so I guess we
> anyway need take a closer look to understand why the usb device is
> accessed when it is actually runtime suspended.
> 
> BTW, Ritesh you could also run a git bisect to find out if/when this
> became broken.

What starting point do you want me to use ? 4.0 ?

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0rWtAAoJEKY6WKPy4XVpgeYP/3FCabIWEOvKeVJK52B5gviF
+CFz00vNVddMDQjUlbN/JzaA8h5HiLMBaTp/7nBvaMYKYKZjjo8iiNQ/3jjwPUu8
S/XrWPvMUVJUhF42OMKTl4uUpVPo3fI18SYIw4XFt5pNaUFrmBPjZ6S23BhqfLN3
x2BSw9rwZrCmxH4aMpfWmDFzjWvkuJ6grpxPfbz2lx4t7BWGs4wWdTc0yfQgzWDR
SLD/CpPCkVFjnpjRnrYZei3nNo0tS0+qSv1SsRwy8GchRbOo9bK1W8YKnLH/AFLb
kCYcVKCc4mq8iq5e05vjPvdppXpbzKKlhpxxtlqzLjAYx9FbESRN89D9c7V1Ng0q
c40b+lQV7AGYUxaf+tOcErflDvzRquR1dcwcjJizgeO/pOI6uXGWE+/T5j+4q4UJ
cypkxjzPIz8SbipNEPGf2nSMppXC1RRcBGo4247vFZ0QYTC7RAViL6ErRS67kfM9
5eX2iBtO3qNZMxIMqBPu97rLoLHSZ3nFEwNbyyFnNHERZuvLUZrZY208tZYUfZKZ
X18QJKPrqfbb9n+KyyLNTaESm6jhW2yYFdiRs/4LQWniOlLLPa+6GOD7E81044nB
t8LAKtSSxK+qvFVcfqrZSfaivRKQZbYwuk+x3O4vAUDgTpTgmugNaDTYendN3v1B
R809X7cWC6V1kzTaBkK9
=o1rL
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
