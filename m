Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A40C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  9 May 2022 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiEIJxb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 May 2022 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiEIJwd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2022 05:52:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECFA217FFD;
        Mon,  9 May 2022 02:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B68ADB80ECC;
        Mon,  9 May 2022 09:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6BC385A8;
        Mon,  9 May 2022 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652089674;
        bh=AQzLlgxL+QKSf+Gp2j0UjXMY67cETeD08hwYn9V6kwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPVtGnjsn6xkzzPyv+15gHKmKoQXcq0SlLaDbQVe9IJaFYBaD437PrzA4tiMZ0eTh
         h4bk2H/h7V67MRFlvIDdYQml9ZbY5+6YH4fBaiY7Bm/6zRTsA3x1eHY4fta8fZtnaP
         /caZ60s5u8kni5S7/G2L+8FbcBDZHYOnMMBNdPl4=
Date:   Mon, 9 May 2022 11:47:51 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ricky WU <ricky_wu@realtek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Message-ID: <YnjjR8pouD4KtHtT@kroah.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
 <CAPDyKFrYWgCbwk6-hNZjtx4mdn7Sx1NJLie+f8wEjS==_HXR5Q@mail.gmail.com>
 <add6c326a5b04525965ffa1e9e96ea41@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <add6c326a5b04525965ffa1e9e96ea41@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, May 09, 2022 at 09:35:25AM +0000, Christian Löhle wrote:
> Can we get 1f311c94aabdb419c28e3147bcc8ab89269f1a7e merged into the stable tree?

Which stable branches do you want this added to?

thanks,

greg k-h
