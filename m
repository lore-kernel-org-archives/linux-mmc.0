From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Thu, 4 Apr 2013 14:43:23 +0000 (UTC)
Message-ID: <loom.20130404T164129-208@post.gmane.org>
References: <1361352662-12263-1-git-send-email-kliu5@marvell.com> <loom.20130404T113956-355@post.gmane.org> <CAPDyKFrmH85XdqogaztEsbdaSwuXGJrQihocTkckdZ48A5-=zQ@mail.gmail.com> <loom.20130404T123942-185@post.gmane.org> <CAPDyKFrmo3s=sHn-jx-=bDjH81SDyWUfVGvnnRz6KTpzjO9zwA@mail.gmail.com> <loom.20130404T141613-473@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49291 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761898Ab3DDOnj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 10:43:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UNlOU-0004kQ-Ca
	for linux-mmc@vger.kernel.org; Thu, 04 Apr 2013 16:44:02 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 16:44:02 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 16:44:02 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Prasanna NAVARATNA <prasanna.navaratna <at> gmail.com> writes:

> 
> So you agree the ocr mask must not be reset during suspend.
> 
> The patch over here exactly addresses the problem which you stated :-
> "mmc core should tell the host driver to use the properly negotiated ocr 
> mask to set the voltage level, both at initialization and at resume"
> 
> The patch saves the ocr which is properly negotiated during initialization 
> time and then restores it back during resume.
> 
> Will you please elaborate, what is wrong with this patch? Or are you 
trying 
> to tell, this is not the proper way to do the same?
> 
> Thanks & Regards,
> Prasanna NAVARATNA
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hello,

I have suggested another patch which does the same thing in better way.
Please refer to the new post "mmc: core: negotiate ocr during resume"

Regards,
Prasanna NAVARATNA


