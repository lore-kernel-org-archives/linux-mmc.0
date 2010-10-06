From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 06 Oct 2010 20:02:00 +0100
Message-ID: <4CACC7A8.6010209@csr.com>
References: <cover.1266847842.git.david.vrabel@csr.com>    <20100827192248.GJ20407@void.printf.net> <4C7CC480.2040903@csr.com>    <4C7F3E0F.2080402@compulab.co.il>    <AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>    <C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>    <AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>    <CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>    <AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>    <4CAC146D.3040001@compulab.co.il>    <AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>    <4CAC7D65.8010705@compulab.co.il>    <AANLkTikvduxP+gQOs4HvZz2Yw6KCrqHAyim0Ads0Bvj_@mail.gmail.com> <56009.192.168.10.88.1286389699.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:40987 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab0JFTDe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2010 15:03:34 -0400
In-Reply-To: <56009.192.168.10.88.1286389699.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

Madhusudhan Chikkature wrote:
> 
> This version should apply fine on the latest kernel. I did a sanity test of
> MMC/SD cards on OMAP4 SDP.

This /looks/ okay to me, but I can't test it.

> From 08b77fd388f19f5df3758a2c59dcdec280f373c8 Mon Sep 17 00:00:00 2001
> From: David Vrabel <david.vrabel@csr.com>
> Date: Wed, 6 Oct 2010 12:39:18 -0500
> Subject: [PATCH 1/2] mmc: omap_hsmmc: enable SDIO card interrupts
> 
[...]
> 
> The writes to STAT and ISE when starting a command are unnecessary and
> have been removed.

Remove this last paragraph from the description as it isn't applicable
any more.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
