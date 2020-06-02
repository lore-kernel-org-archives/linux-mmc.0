Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB80C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095A420734
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 00:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ed4EFlhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFBAfR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFBAfR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 20:35:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D85C061A0E;
        Mon,  1 Jun 2020 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=FlmMhR/i1JrrP4rHZh5a3Tp0mbELytRh4Nj/4ZUxf24=; b=ed4EFlhyDtDTNwMw8dw7i3xbS8
        gW22VgZqvNhCX1dmDPenCxQnkYdxz/Y+k0Pd6bUuo4HLfhks5KFPQv96Hr7HcGBh7jno99AVO9IDi
        YlcuVDjRZpACmg7sAvVwUb+aYeDFo0n2dZuUFvC6QvnZkrg3ENSK2+3rdXRrPuMpDdlsESmil0Hqh
        DOQTpdGcUwX+sKbad8nRbD1Bf3l4n1VCb4ab4/qtBpt7LxUTuzAqlWL/sUIaxIW81UxCfH5CRHMnO
        WbDd8BsRgY95OLylP+NCFeGI3lylx3ayq3YpRqO15bzIcnK/hEdNOpaabjF5ASAjWVIJzJ30dIjqw
        swGBSEFQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jfutb-00070u-LA; Tue, 02 Jun 2020 00:35:11 +0000
Subject: Re: Bug in your kernel since version 5.2
To:     Philip Schwartz <philquadra@gmail.com>,
        linux-kernel@vger.kernel.org, RickyWu <ricky_wu@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <CACYmiSfM00o864c5pxxWEQNZsgFMkNwJePCGvae6P7o31NXMyw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0fc7c8c2-ac6a-2b66-074b-92b5d03219b6@infradead.org>
Date:   Mon, 1 Jun 2020 17:35:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACYmiSfM00o864c5pxxWEQNZsgFMkNwJePCGvae6P7o31NXMyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[adding Cc:s and comments]


On 6/1/20 3:52 PM, Philip Schwartz wrote:
> This is my sixth attempt to send a bug report.
> 
> The first time you didn't like my email address.
> The second time you didn't like that I copied the whole url.
> The third time you didn't like that the part of the url that I copied
> looked a bit like a url.
> The fourth time you complained that "The message contains HTML
> subpart,therefore we consider it SPAM"

Yes.

> The fifth time you didn't like ?????????.
> 
> Kernel dot org Bugzilla       I D equals  204003
> 
> 
> I look forward to your email rejection message.


Please see https://bugzilla.kernel.org/show_bug.cgi?id=204003

Several people are having problems with Intel NUCs and/or
the RTS5229 PCI Express Card Reader/driver, beginning with
5.1-rc1.

Here is one bugzilla comment:
Did a git bisect and found the culprit.

bede03a579b3b4a036003c4862cc1baa4ddc351f is the first bad commit
commit bede03a579b3b4a036003c4862cc1baa4ddc351f
Author: RickyWu <ricky_wu@realtek.com>
Date:   Tue Feb 19 20:49:58 2019 +0800

    misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
    
    this enables and adds OCP function for Realtek A series cardreader chips
    and fixes some OCP flow in rts5260.c
    
    Signed-off-by: RickyWu <ricky_wu@realtek.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 65bfdc473b7b85cb423ff528309fc92d73eae5b4 1292d8564f678027d0e5c77550e37d696b134b28 M	drivers

Just revert that and you'll be golden.

rts522a,rts524a,rts525a,rts5260
So somehow OCP got enabled for rts5229 unless a means rts522x. I guess they need to make sure its not enabled for 5229.
{end of bugzilla comment}



-- 
~Randy

