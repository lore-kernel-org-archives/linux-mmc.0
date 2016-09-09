From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Fri, 09 Sep 2016 19:34:44 +0530
Message-ID: <1473429884.9415.8.camel@researchut.com>
References: <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
         <Pine.LNX.4.44L0.1609071630350.2115-100000@iolanthe.rowland.org>
         <CAPDyKFr0vEaEbsoPm6YwJD1JOQc=YR=zwi4T6Rr3gCQ4StNuvg@mail.gmail.com>
         <1473426861.9415.2.camel@researchut.com>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473426861.9415.2.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, 2016-09-09 at 18:44 +0530, Ritesh Raj Sarraf wrote:
> On Fri, 2016-09-09 at 12:54 +0200, Ulf Hansson wrote:
> > This affects the way the core calls the host driver's ->set_ios()
> > callback. Earlier it was invoked first to do power off then power up.
> > With this change it starts with power up instead.
> > I wanted to try this because I suspected the initial state could be wrong.
> > 
> > So here are some other ideas on how to move forward.
> > 1. Run with CONFIG_PM unset to see if we can reproduce the problem.
> > 2. Revert back the state in the mmc core we had in 3.16 around how it
> > deals with runtime PM for host devices. That's actually very easy as
> > we only need to remove the pm_runtime_put|get() calls in
> > mmc_claim|release_host().
> > 
> > Ritesh, can you try these options?
> > 
> 
> Yes. I can try the above ones now. I'm building the kernel for it.

For #1, menuconfig doesn't allow me to disable CONFIG_PM in 4.8. I checked it
back up till 4.0, and it still doesn't allow disabling CONFIG_PM.

For #2, I'm building the 4.8-rc5 kernel with the following change. This build
does not include the previous change you had suggested (related to POWER_CYCLE)

Date:   Fri Sep 9 19:28:03 2016 +0530

    Disable pm runtime in mmc core

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e55cde6..32388d5 100644
- --- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -970,9 +970,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
        spin_unlock_irqrestore(&host->lock, flags);
        remove_wait_queue(&host->wq, &wait);
 
- -       if (pm)
- -               pm_runtime_get_sync(mmc_dev(host));
- -
        return stop;
 }
 EXPORT_SYMBOL(__mmc_claim_host);
@@ -1000,7 +997,6 @@ void mmc_release_host(struct mmc_host *host)
                spin_unlock_irqrestore(&host->lock, flags);
                wake_up(&host->wq);
                pm_runtime_mark_last_busy(mmc_dev(host));
- -               pm_runtime_put_autosuspend(mmc_dev(host));
        }
 }
 EXPORT_SYMBOL(mmc_release_host);


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0sF8AAoJEKY6WKPy4XVpmDQQAKPpzuw4QaaYdGuoEdZs9tvL
ZIVXOp81QVFg/VC+k8b5JmxcVmyaRrAmlKwKSBUrQqLsRIDROKHz7kAZmABvvmMo
8PC+haslv6o+M/xTd2kZMgYRk0Xj11+Ucr6mTd0BVbTqzD86WZhSmdufeiFWhzjB
aMloMDJ3cYABMIHqPQH5S/+knNhuffKqEEZ1O7jgcc10c/JpwpxaAlefNLh9Qotk
bsb+ptpBE0ggk8gD/tGSx6JZLNFy15JyzE8yuL8LfrZzzW2KU8M4kv94+6BNMqpE
sJ1mapW3zu52Hev9cDpUeTgyVVEOEXJKu9AM626voyxVYrCEwrE4usUcLVsdJH17
p7Rm5gBiEK/Wx+f10CBiFW2HwdE0KmeBgxweprv+E6VXaWFkjoXSJY5DDX5zuxlf
we9onx87IaGVTLN0I7dEcVse/3T3zT8URM/HwFyR6K+PWD0Ioiyoi4GIE96OCIJn
oUahrupOppgUZbr+qn+HULHLXJONWBslZmbS3gjQG282+koy00wquAou+4HznA5z
DBLPaljAaIuIPKxKrIDOcJ3nxBh5eBf0RHXsn9Ho6iWrcpPqYtN2XuDWNhOA/wJB
eEm1TQAMmi83FATZ0qf0n70E1/mv2wrV4nSzHPqeIgtexABWLqhS8fLCEuMW6ESt
zMRmOrou7dzaXfwkGzhC
=2dkl
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
