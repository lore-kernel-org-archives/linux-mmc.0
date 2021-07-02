Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57AC11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 07:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0487761416
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 07:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGBHq0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhGBHq0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 03:46:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB850C061762;
        Fri,  2 Jul 2021 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CH7z9dtJCn3XGrA5BFatrdCjnmJPJqFx9k28BJYvw4=; b=q2JQaIVtatEQvVrOP2vatbAjeP
        QvnrFDnIb0xmoMuWF4uziCNyxvVulfk0rA1DCoAFzMocwPjGqRns905dFsmCH7iflD1E5SSIgL0Uf
        vBhUmpg86jy3IE1ljUG1eJ1i4+Jxy8x0x27UUEY9st9mfixYSKpGIzqt7N/WDDlifVWxtWDhcGI6C
        KuDiYiW8GzxIbznEtk4riXcXIL8HgKdSwa/4iPHMkObJWezpNaZ4K37+NABStwwfhPcfs8kL7eSHy
        uoDQjuj/mZIZ+nhj6clhVhORBTiiT4KUKhJtyg97/HAgkggke7AQdsS0MfxTDkGLaTnf+xIgvF35Z
        pxb8KbtA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzDps-007SyF-D2; Fri, 02 Jul 2021 07:43:44 +0000
Date:   Fri, 2 Jul 2021 08:43:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian L?hle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Message-ID: <YN7DrIxI2QSDhoy4@infradead.org>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> +	/*
> +	 * Cards will never return to TRAN after completing
> +	 * identification commands or MMC_SEND_STATUS if they are not selected.
> +	 */
> +	return !(cmd->opcode == MMC_GO_IDLE_STATE
> +			|| cmd->opcode == MMC_SEND_OP_COND
> +			|| cmd->opcode == MMC_ALL_SEND_CID
> +			|| cmd->opcode == MMC_SET_RELATIVE_ADDR
> +			|| cmd->opcode == MMC_SET_DSR
> +			|| cmd->opcode == MMC_SLEEP_AWAKE
> +			|| cmd->opcode == MMC_SELECT_CARD
> +			|| cmd->opcode == MMC_SEND_CSD
> +			|| cmd->opcode == MMC_SEND_CID
> +			|| cmd->opcode == MMC_SEND_STATUS
> +			|| cmd->opcode == MMC_GO_INACTIVE_STATE
> +			|| cmd->opcode == MMC_APP_CMD);

This is not the normal kernel style, which puts operators at the end
of the line.  And while a little more verbose I think a switch statement
would be a lot more readable here:

	switch (cmd->opcode) {
	case MMC_GO_IDLE_STATE:
	case MMC_SEND_OP_COND:
	case MMC_ALL_SEND_CID:
	case MMC_SET_RELATIVE_ADDR:
	case MMC_SET_DSR:
	case MMC_SLEEP_AWAKE:
	case MMC_SELECT_CARD:
	case MMC_SEND_CSD:
	case MMC_SEND_CID:
	case MMC_SEND_STATUS:
	case MMC_GO_INACTIVE_STATE:
	case MMC_APP_CMD:
		return false;
	default:
		return true;
	}
