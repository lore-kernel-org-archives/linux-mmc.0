From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 15:42:25 +0200
Message-ID: <c70ff3ad1003180642n1d9410a9g35c24b06df6afef0@mail.gmail.com>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	 <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	 <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	 <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	 <20100318092352.GD8267@n2100.arm.linux.org.uk>
	 <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	 <20100318112453.GA19544@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:54459 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0CRNm0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 09:42:26 -0400
Received: by yxe12 with SMTP id 12so52142yxe.33
        for <linux-mmc@vger.kernel.org>; Thu, 18 Mar 2010 06:42:25 -0700 (PDT)
In-Reply-To: <20100318112453.GA19544@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Hemanth V <hemanthv@ti.com>, linux-mmc@vger.kernel.org, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

> In no case does the kernel ever clean user space cache lines for DMA;
> that's not the responsibility of the DMA API.
I understand that it's not the DMA API's responsibility to flush user
space cache lines, but other parts of the kernel should do that right?
otherwise DIRECT_IO won't work (though the issue here has nothing to
do with DIRECT_IO).

saeed
