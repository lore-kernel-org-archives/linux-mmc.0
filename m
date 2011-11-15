From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Tue, 15 Nov 2011 14:57:58 +0800
Message-ID: <5D8008F58939784290FAB48F549751984E6510F91D@shsmsx502.ccr.corp.intel.com>
References: <4EBCC49E.5060008@st.com> <877h36hvki.fsf@laptop.org>
 <4EC1FCC1.6070609@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_003_5D8008F58939784290FAB48F549751984E6510F91Dshsmsx502ccrc_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46502 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220Ab1KOHAm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Nov 2011 02:00:42 -0500
In-Reply-To: <4EC1FCC1.6070609@st.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

--_003_5D8008F58939784290FAB48F549751984E6510F91Dshsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,
I also meet the hang issue when suspending a system with a mounted SD card.=
 Actually it caused by a dead lock of mmc_claim_host. Maybe we faced the sa=
me issue.
So may be the two mails in the attachment can help you.

Thanks
Chuanxiao

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Viresh Kumar
> Sent: Tuesday, November 15, 2011 1:47 PM
> To: Chris Ball
> Cc: linux-mmc@vger.kernel.org; Shiraz HASHIM; Armando VISCONTI
> Subject: Re: [Query] mmc/sdhci: Suspend hangs if card is inserted at susp=
end.
>=20
> On 11/12/2011 8:54 AM, Chris Ball wrote:
> > On Fri, Nov 11 2011, Viresh Kumar wrote:
> >> > Controller specific suspend/resume are still not called, so i think =
it might
> >> > be related to core code. I am using 2.6.37 kernel version.
> >> >
> >> > Any help on this?
> > Please try to reproduce on 3.1 and let us know if it's present there.
>=20
> Hi Chris,
>=20
> Support for SPEAr13xx is not present on 3.1 and it will take some time to
> move support there. I have a bit more info which might able you to guide =
us:
>=20
> file: drivers/mmc/card/queue.c
>=20
> static int mmc_queue_thread(void *d)
> {
> 	...
> 	do {
> 		req =3D blk_fetch_request(q);
> 		...
> 		if (!req) {
> 			if (kthread_should_stop()) {
> 				set_current_state(TASK_RUNNING);
> 				break;
> 			}
> 			up(&mq->thread_sem);
> 			schedule();
> 			down(&mq->thread_sem);
> 			continue;
> 		}
> 		set_current_state(TASK_RUNNING);
> 		mq->issue_fn(mq, req);
> 	} while (1);
> 	...
> }
>=20
> - In normal cases, i.e. when we are able to stop this thread,
>   req is returned as NULL from blk_fetch_request()
> - Suspend hang only occurs when the card is mounted.
> - When suspend hangs, req is not returned as NULL and the card is
>   already removed by kernel and so we never check kthread_should_stop().
>   So it hangs.
>=20
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--_003_5D8008F58939784290FAB48F549751984E6510F91Dshsmsx502ccrc_
Content-Type: message/rfc822

Received: from fmsmsx104.amr.corp.intel.com (10.19.9.35) by
 SHSMSX602.ccr.corp.intel.com (10.239.4.104) with Microsoft SMTP Server (TLS)
 id 8.2.255.0; Tue, 17 May 2011 16:04:09 +0800
Received: from rrsmsx605.amr.corp.intel.com (10.31.1.129) by
 FMSMSX104.amr.corp.intel.com (10.19.9.35) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Tue, 17 May 2011 01:04:06 -0700
Received: from azsmga001.ch.intel.com (10.2.17.19) by RRSMSX605-1.rr.intel.com
 (10.31.1.129) with Microsoft SMTP Server id 8.2.255.0; Tue, 17 May 2011
 02:04:06 -0600
Received: from azsmga102.ch.intel.com ([10.2.16.52])  by
 azsmga001-1.ch.intel.com with ESMTP; 17 May 2011 01:04:02 -0700
Received: from vger.kernel.org ([209.132.180.67])  by mga14.intel.com with
 ESMTP; 17 May 2011 01:04:01 -0700
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id
 S1752730Ab1EQIEA (ORCPT <rfc822;charles.f.johnson@intel.com>	+ 4 others);
 Tue, 17 May 2011 04:04:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:2660 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP	id S1752624Ab1EQID6
 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);	Tue, 17 May 2011 04:03:58 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])  by
 fmsmga102.fm.intel.com with ESMTP; 17 May 2011 01:03:57 -0700
Received: from unknown (HELO intel.com) ([172.16.120.198])  by
 fmsmga002.fm.intel.com with ESMTP; 17 May 2011 01:03:57 -0700
From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "He, Bo" <bo.he@intel.com>
Sender: "linux-mmc-owner@vger.kernel.org" <linux-mmc-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
Date: Tue, 17 May 2011 15:53:52 +0800
Subject: [RFC]mmc: fix dead lock issue when system entering S3
Thread-Topic: [RFC]mmc: fix dead lock issue when system entering S3
Thread-Index: AcwUaQLOgUV7ksPURUqFKBbWIoSJ+Q==
Message-ID: <20110517075352.GA3992@intel.com>
Reply-To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: RRSMSX605.amr.corp.intel.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-TNEF-Correlator: 
x-ironport-av: E=Sophos;i="4.65,224,1304319600";    d="scan'208";a="2660232"
x-extloop1: 1
x-ironport-anti-spam-filtered: true
x-ironport-anti-spam-result: ApwEAB0r0k3RhLRDkWdsb2JhbACYC44OFAEBAQEJCwsHFAYfyDqGGQSGTolDhEyKNg
list-id: <linux-mmc.vger.kernel.org>
user-agent: Mutt/1.5.20 (2009-12-10)
x-sg-badattachmentnoreply: True
x-mailing-list: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Hi all,
   I encountered a dead lock issue. Two threads try to claim host, unfortun=
ately
   one thread needs to sync with the other. I encountered this issue with S=
D
   card when testing system entering S3. Does anybody encounter the same is=
sue?

Environment:
1. without CONFIG_MMC_UNSAFE_RESUME operation
2. the SD card mounted

During system tried to enter S3, mmc_pm_notifier will be called first to re=
move
SD card. So calling sequence in SD remove thread is like this:
        mmc_claim_host
        bus_ops->remove
        ....
        ....
        mmc_cleanup_queue
        kthread_stop(mq->thread)
        ...
        ...

Mean while, mmc_cleanup_queue wakes up mq->thread, the calling sequence in =
mq->thread is
like this:
        mmc_queue_thread
        mq->issue_fn (mmc_blk_issue_rq)
        mmc_claim_host (dead lock)
        ....
        ....

Since mmc_claim_host is called in mq->thread (not SD remove thread) again,
unfortunately right now host is already claimed by SD remove thread which i=
s
also waiting for mq->thread finished, so cause a dead lock here.

Move the mmc_claim_host(in mmc_pm_notifier) after bus_ops->remove can resol=
ve
this dead lock. mmc_suspend_host() is using the same way to claim host.

Need to know your suggestions.

Signed-off-by: He Bo <bo.he@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..1e27588 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1850,11 +1850,10 @@ int mmc_pm_notify(struct notifier_block *notify_blo=
ck,
                if (!host->bus_ops || host->bus_ops->suspend)
                        break;

-               mmc_claim_host(host);
-
                if (host->bus_ops->remove)
                        host->bus_ops->remove(host);

+               mmc_claim_host(host);
                mmc_detach_bus(host);
                mmc_release_host(host);
                host->pm_flags =3D 0;
--
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--_003_5D8008F58939784290FAB48F549751984E6510F91Dshsmsx502ccrc_
Content-Type: message/rfc822

Received: from orsmsx606.amr.corp.intel.com (10.22.226.128) by
 shsmsx601.ccr.corp.intel.com (10.239.4.112) with Microsoft SMTP Server (TLS)
 id 8.2.255.0; Wed, 18 May 2011 15:58:57 +0800
Received: from fmsmga001.fm.intel.com (10.253.24.23) by
 orsmsx606-1.jf.intel.com (10.22.226.128) with Microsoft SMTP Server id
 8.2.255.0; Wed, 18 May 2011 00:58:55 -0700
Received: from fmsmga102.fm.intel.com ([10.1.193.69])  by
 fmsmga001-1.fm.intel.com with ESMTP; 18 May 2011 00:58:55 -0700
Received: from exprod5og106.obsmtp.com ([64.18.0.182])  by mga11.intel.com
 with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 May 2011 00:58:54 -0700
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([192.54.82.14]) (using TLSv1)
 by exprod5ob106.postini.com ([64.18.4.12]) with SMTP	ID
 DSNKTdN8PoVkLykWKnZwaJ5+dk1/sk0aCRm8@postini.com; Wed, 18 May 2011 00:58:55
 PDT
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])	by
 DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4I7xNVQ007339;
	Wed, 18 May 2011 03:59:23 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
 [74.125.82.170])	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP
 id p4I7upRj006465	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK);
	Wed, 18 May 2011 03:58:30 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1173841wyb.15
        for <multiple recipients>; Wed, 18 May 2011 00:58:01 -0700 (PDT)
Received: by 10.216.197.168 with SMTP id t40mr1548119wen.55.1305705480870;
 Wed, 18 May 2011 00:58:00 -0700 (PDT)
Received: by 10.216.183.142 with HTTP; Wed, 18 May 2011 00:58:00 -0700 (PDT)
From: Andrei Warkentin <andreiw@motorola.com>
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "He, Bo"
	<bo.he@intel.com>
Content-Class: urn:content-classes:message
Date: Wed, 18 May 2011 15:58:00 +0800
Subject: Re: [RFC]mmc: fix dead lock issue when system entering S3
Thread-Topic: [RFC]mmc: fix dead lock issue when system entering S3
Thread-Index: AcwVMXCX4FsToi8ATkyDe4BIZROHUw==
Message-ID: <BANLkTi=H5NR4vzkD+X4fZXw-PPFYwO51ow@mail.gmail.com>
References: <20110517075352.GA3992@intel.com>
	<5D8008F58939784290FAB48F54975198419F75426B@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <5D8008F58939784290FAB48F54975198419F75426B@shsmsx502.ccr.corp.intel.com>
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: orsmsx606.amr.corp.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cfilter-loop: Reflected
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Hey,

On Tue, May 17, 2011 at 5:03 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
> Just found Andrei Warkentin also submitted a RFC patch, which included mo=
re fix for mounted root file system media. Please ignore this thread.

I submitted an RFC patch as an idea up for discussion, but certainly
the issue never went away :-).. Your patch will not quite work. If you
have a filesystem it will not unmount, so mmc0 (for example) will
never release, so when a new (or same) card re-enumerates, it will be
mmc1...

I believe my patch basically created "md orphans" which would be
reconnected on resume, which is bit of a really nasty hack... I'm not
sure if there is a better way. I could have sworn I saw a patch a week
ago that attempted to resolve the suspend/resume with mounted fs issue
by deferring removal until resume, but I don't see it now, and I'm not
sure if it dealt well with the whole attempting to unmount fs in mmc
block cleanup path...

I guess I can resubmit...

A

--_003_5D8008F58939784290FAB48F549751984E6510F91Dshsmsx502ccrc_--
