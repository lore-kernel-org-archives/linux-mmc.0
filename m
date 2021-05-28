Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EEC47089
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06CC613C9
	for <linux-mmc@archiver.kernel.org>; Fri, 28 May 2021 00:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhE1AWs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 May 2021 20:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhE1AWs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 May 2021 20:22:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B112613BA;
        Fri, 28 May 2021 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622161274;
        bh=U1AN8rNrgVKQfco3QAqUivNmHVm5c62XQRy1Q6f0q/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8FYpAkb5vyXiW7eAms9yw4zVbssfuMMN4n9UyAbeaSJuYBivItcKBcP+yioZdCSB
         VmmijmtoFSPK+1ytQFnMAjm8XsIQUBis0P+MeHXFkNV/2N9UMQCBbvI6Cda/qaWi7B
         BwWX0Q7C+cV2vPZ33UU9gGU1asoBJqnhsYWJOHKBfRNrNospcccNaocm/GFH8A74wk
         mjXE+ixy8nbaXoZNdmtQ3kQ9rqn/GCSKkLZtUwMe+wAdwlWWBItSCbVThghPYlk1Nl
         qvZEfVTIXGSulZWgwPmAaGclirZ0N9LCsmmvWpTPNp7RmsyewgqJrr5tqiI4eX2uCr
         3uwtTT8F5y9AA==
Received: by pali.im (Postfix)
        id 0B8AF894; Fri, 28 May 2021 02:21:11 +0200 (CEST)
Date:   Fri, 28 May 2021 02:21:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: Who assigns SDIO vendor IDs?
Message-ID: <20210528002111.wei44qtoptgj6mlo@pali>
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

Hello Ulf! Do you know something about SDIO vendor ID assignment?

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
