From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Fri, 5 Apr 2013 06:07:11 +0000 (UTC)
Message-ID: <loom.20130405T080017-884@post.gmane.org>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com> <loom.20130404T113956-355@post.gmane.org> <CAPDyKFrmH85XdqogaztEsbdaSwuXGJrQihocTkckdZ48A5-=zQ@mail.gmail.com> <loom.20130404T123942-185@post.gmane.org> <CAPDyKFrmo3s=sHn-jx-=bDjH81SDyWUfVGvnnRz6KTpzjO9zwA@mail.gmail.com> <loom.20130404T141613-473@post.gmane.org> <loom.20130404T164129-208@post.gmane.org> <CAPDyKFp8LEd7qb+afJbvUZFSNuDVL3SXshnEH5cuhSgH8L+drA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52207 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab3DEGH2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Apr 2013 02:07:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UNzoT-0007uW-Tk
	for linux-mmc@vger.kernel.org; Fri, 05 Apr 2013 08:07:50 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 05 Apr 2013 08:07:49 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 05 Apr 2013 08:07:49 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson <at> linaro.org> writes:

> "host->ocr" is intended for keeping the negotiated ocr mask. Another
> variable is not needed.
> 
> A proper patch would in principle remove the workaround, which means
> the reset of the "host->ocr" in mmc_power_off is not done any more.
> 
> Exactly what you need to make this work, is as stated before a bit
> more complicated.

Hello Ulf,

The work around is introduced by yourself :-
"At power off, reset OCR mask to be the highest possible voltage
supported for the current mmc host.

This solves the re-initialization during the power up sequence.
The voltage may have been decreased due to the card accepts a lower
voltage than the voltage used during the initialization sequence.
We need to reset the voltage to by the host highest possible value
since according to _specification_ the initialization must always be
done at high voltage"

So do you think, solution to current issue is to revert this patch? This 
will not violate the spec as you are mentioning above?
If you agree, i'll push a new patch by reverting this. Else consider another 
way in my new post "mmc: core: negotiate ocr during resume"
This patch will follow the spec and will also negotiate ocr during 
mmc_resume_host.

Thanks,
Prasanna NAVARATNA

