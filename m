From: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
Date: Fri, 06 Aug 2010 12:53:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008061251040.28809@xanadu.home>
References: <AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com>
 <AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d@mail.gmail.com>
 <AANLkTikfRja-h9mz7uyRXCZNZjKdU_yB8e58XQucUzrn@mail.gmail.com>
 <AANLkTi=vhWV1RNyemtfppfjvLYAbzd3aRjFOVgLLpG3Z@mail.gmail.com>
 <AANLkTin4m8gJR50zwMB2b0jRMHdNA6CQToKBTAhOL9wF@mail.gmail.com>
 <AANLkTinu2S19r8fueM-jVkc35XL2G0Z16BddE92Ci9KB@mail.gmail.com>
 <20100804114147.GB6852@n2100.arm.linux.org.uk>
 <AANLkTi=Dqs_qg=BsoNBTjvJbG+ub+zMv8ctbrJSGPJJJ@mail.gmail.com>
 <AANLkTimrb5P9cVo30y_udoi4+vu3cM4YzfpDaYCfwGEA@mail.gmail.com>
 <AANLkTim6Yuor4CAEmQPs3zPVz1svEbckzO0HHeFWGmjy@mail.gmail.com>
 <20100806144605.GA21015@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20100806144605.GA21015-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 6 Aug 2010, Russell King - ARM Linux wrote:

> On Fri, Aug 06, 2010 at 01:02:24PM +0300, Ohad Ben-Cohen wrote:
> > We have Russell's suggestion which is nice and simple, but it has the
> > 1 device limitation.
> 
> You could make it generic by doing something like this:
> 
> #define set_device_data(name, type, index, data)			\
>  ({									\
>     extern void __set_device_data(const char *, int, void *, size_t);	\
>     BUILD_BUG_ON(!__same_type(type, *data));				\
>     __set_device_data(name ":" #type, index, data, sizeof(type));	\
>  })
> 
> #define get_device_data(name, type, index) ({				\
>   extern void *__get_device_data(const char *, int);			\
>   type *__ptr = __get_device_data(name ":" #type, index);		\
>   __ptr; })
> 
> And now we have something that takes a string and index to use as a lookup
> key in some kind of list - and it's typesafe (because the lookup key is
> dependent on the stringified type.)
> 
> But... at this point I feel that we're getting too complicated, and will
> get shouted at to use something like DT which already solves this problem.

DT is not generally available yet.  A simple interim solution would 
still be worth it.


Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
