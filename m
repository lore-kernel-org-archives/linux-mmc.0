Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9AC47095
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9C861185
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGOEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhFGOEK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Jun 2021 10:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E186109F
        for <linux-mmc@vger.kernel.org>; Mon,  7 Jun 2021 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623074538;
        bh=JMKYP+6tT6g9y9E2tt3sjkwSmAITD02tyQF/45gf6KM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=k7VWFHxHMCeIKAwYpoSGkh9a7Stu9FDluCzj5c0z5a8Mr1gBEqFGH6IQNn8J73A/v
         meqniNQAodr9ChRv+yn8mHTrbwxSAEhhxr247UvXP2a6AjbSUa0MOCTeY9DRHqxL8V
         2d6lGNpI3qGjdxFi1VjujTXxtXKzUEN16ns9fxEk0Ldd3hihyEEvceoQBk4RyEST8k
         tGwqsrlg/qtVtThCauYTVoTgYJIugHoCfWTZEmE6vRyDkymwbO7UK0HIody8Tc72lc
         1ZxRUM0penjwo+k8QVkwbcrKOVVcrxd+dNPpHZwr4mjNQqf8O2K2y0d/FxG7zQqhWs
         VgsFQmAKlHKMA==
Received: by pali.im (Postfix)
        id 65928CB8; Mon,  7 Jun 2021 16:02:16 +0200 (CEST)
Date:   Mon, 7 Jun 2021 16:02:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-mmc@vger.kernel.org
Subject: Re: Who assigns SDIO vendor IDs?
Message-ID: <20210607140216.64iuprp3siggslrk@pali>
References: <20210514171233.qerhkjn3redivien@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514171233.qerhkjn3redivien@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Friday 14 May 2021 19:12:33 Pali Rohár wrote:
> Hello!
> 
> I would like to ask if somebody knows who assigns SDIO vendor IDs?
> 
> In SDIO Simplified Specification Version 3.00 available from website
> https://www.sdcard.org/downloads/pls/ in section 16.6 CISTPL_MANFID is:
> 
>   The TPLMID_MANF field identifies the SDIO Card's manufacturer. New
>   codes are assigned by both PCMCIA and JEIDA. The first 256 identifiers
>   (0000h through 00FFh) are reserved for manufacturers who have JEDEC
>   IDs assigned by JEDEC Publication 106. Manufacturers with JEDEC IDs
>   may use their eight-bit JEDEC manufacturer code as the least
>   significant eight bits of their SDIO Card manufacturer code. In this
>   case, the most significant eight bits shall be zero (0).  For example,
>   if a JEDEC manufacturer code is 89h, their SDIO Card manufacturer code
>   is 0089h. If a SDIO card manufacturer does not currently have a
>   TPLMID_MANF assigned, one can be obtained at little or no cost from
>   the PCMCIA.
> 
> So IDs 0x0000 - 0x00FF are assigned by JEDEC 106 and because JEDEC 106
> contains one parity bit, it means that only 128-reserved IDs are
> available for SDIO vendor ids and they were already assigned. This is
> basically clear and list of these (id, vendor) tuples can be find in
> JEDEC 106 publication.
> 
> But who assigns remaining SDIO vendor IDs 0x0100 - 0xFFFF? PCMCIA
> website http://www.pcmcia.org/ is already down and according to USB-IF
> press information found in document USB_IF_01212010.pdf from archive
> https://web.archive.org/web/20160304121938if_/http://www.usb.org/press/USB_IF_01212010.pdf
> USB-IF acquired PCMCIA assets which probably means also assigning PCMCIA
> vendor IDs.
> 
> In archive of www.pcmcia.org is available very old list of vendor IDs:
> https://web.archive.org/web/20051202104141/http://www.pcmcia.org/tupleid.htm
> 
> I have tried to find some information about PCMCIA or SDIO vendors and
> IDs assignment on USB-IF website https://www.usb.org/ but there is
> absolutely nothing.
> 
> So has somebody any clue what happened with PCMCIA and its relation with
> SDIO vendor IDs?

Hello!

So to answer my own question, we got information that USB-IF really
maintains and assigns PCMCIA vendor ids which are still used also for
SDIO vendor ids in SDIO cards.

New version 4 of SDIO specification mention this fact but "Simplified"
specification which is freely available and from which I quoted part
about CISTPL_MANFID was not updated yet to reflect changes.
