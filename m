Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5A9C388F7
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB78222B9
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604385502;
	bh=FPjzF3WG+1nROwjRngPTor3p1eCnrBE7BR72hTI2w7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tAABJGpIhaiEZPr7sitIwBuMGa27DYIjpTw/nTHpMC6Qwq/OEKZTHLMLVQBfvrylf
	 C9zB0gBnWusddpyPpHuoOFH37BJWUbWmYHRyF3/K2ZsiuhHqZG3OT8pmuewGat6Up/
	 zG5hEnF6r44ckclYvG9Fo9yn4TK7bXFF9F+y7/Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKCGiV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCGiV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Nov 2020 01:38:21 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F312227F;
        Tue,  3 Nov 2020 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604385500;
        bh=FPjzF3WG+1nROwjRngPTor3p1eCnrBE7BR72hTI2w7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYX6otrUkHFU+rucDzM/Nxle+mYTrKRd0prpk7SwSKhrszIMEYDxMc1jBaFBY/SIH
         5UgIk6ojDVZ2GD5M5kqGDgjSnEDYMyzCGejWBeIFBJwL0zzPPWoCLFR8CY4Wn7d5lm
         zrQt0KY7097addDiwDgkJoogd3DYqAMHRkO/8sdw=
Date:   Tue, 3 Nov 2020 07:38:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rui_feng@realsil.com.cn
Cc:     arnd@arndb.de, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: Fix some bugs and add test mode for rts5261
Message-ID: <20201103063816.GA74830@kroah.com>
References: <1604374035-2945-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604374035-2945-1-git-send-email-rui_feng@realsil.com.cn>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 03, 2020 at 11:27:15AM +0800, rui_feng@realsil.com.cn wrote:
> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> 1.Add force test mode
> 2.Fix OCP function
> 3.Use aspm in way of backdoor
> 4.Fix PAD driving
> 5.Not support MMC default
> 6.Support CD&WP reverse
> 7.Add hardware auto power down when unplug card

When you have to list the different things you are doing in a single
patch, that is a huge sign that you need to break this up into much
smaller patches.  Please turn this patch into a patch series, each patch
only doing one logical thing.

thanks,

greg k-h
