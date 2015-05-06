From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Wed, 06 May 2015 09:31:42 +0200
Message-ID: <4635229.bceBxngCoe@wuerfel>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com> <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com> <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56999 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbEFHcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 03:32:08 -0400
In-Reply-To: <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Rob Herring <robherring2@gmail.com>, "chris@printf.net" <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, "patches@apm.com" <patches@apm.com>

On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
> >> @@ -533,6 +567,16 @@
> >>                         interrupts = <0x0 0x4f 0x4>;
> >>                 };
> >>
> >> +               sdhc0: sdhc@1c000000 {
> >> +                       device_type = "sdhc";
> >
> > device_type generally should not be used (there are a few exceptions).
> 
> Okay !!
> 

While we're at it, please change sdhc@1c000000 to mmc@1c000000.
Even though Linux does not care, we try to use the standard device
names for consistency.

	Arnd
