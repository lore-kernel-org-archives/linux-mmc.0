From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: HIBERNATION: add resume_wait param to support MMC-like devices as resume file
Date: Wed, 5 Oct 2011 00:30:43 +0200
Message-ID: <201110050030.43953.rjw@sisk.pl>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com> <59872.1317299401@turing-police.cc.vt.edu> <CAGsJ_4znTLmjd_qhgru_aOZPMEZc=dyXEQTqdsVGKr-GaryQsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48045 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933180Ab1JDW2Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Oct 2011 18:28:25 -0400
In-Reply-To: <CAGsJ_4znTLmjd_qhgru_aOZPMEZc=dyXEQTqdsVGKr-GaryQsQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Barry Song <Barry.Song@csr.com>, frank.hofmann@tomtom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, pavel@ucw.cz, Barry Song <baohua.song@csr.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Thursday, September 29, 2011, Barry Song wrote:
> hi Valdis,
> 
> 2011/9/29  <Valdis.Kletnieks@vt.edu>:
> > On Thu, 29 Sep 2011 02:29:08 PDT, Barry Song said:
> >
> >> This patch adds resumewait kernel param just like rootwait so
> >> that we have enough time to wait mmc ready. The differene is
> >> here we wait for resume partition but rootwait waits for rootfs
> >> partition.
> >
> > OK, seems a reasonable idea...
> >
> >> kernel/power/hibernate.c |   16 ++++++++++++++++
> >> 1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > We have a __setup() parameter, this patch appears to be missing
> > a hunk for Documentation/kernel-parameters.txt?
> >
> > Fix that issue, and you can stick this on there:
> >
> > Reviewed-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> thanks. i'll add the document in v2.

I can't find the v2.  Have you posted it already?

Rafael
