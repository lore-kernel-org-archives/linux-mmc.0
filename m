Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41164C41513
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jul 2023 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGaSUI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGaSUF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2023 14:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1419AA;
        Mon, 31 Jul 2023 11:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC0C6125A;
        Mon, 31 Jul 2023 18:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD9BC433B9;
        Mon, 31 Jul 2023 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690827601;
        bh=AL8IQvRuROckVk8brJfkavPt8PtZd1aJDIS2DkRo6uA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxEq1KPXwyVC1XodEZWtEzrbM+XLI07D7cJOSKzt1Oscom6oVTU1lwGFJPA5F6uBJ
         6qL57Cigp7iSIR5GUFKTHhgLDYNw3s54jdNApWbMEkaJC1YsJcasDjaQaL1O05SJLG
         Ic7ZS7rI9/EYJGe/xRS02qJvdI7YVFP9rsSQPB3ATnZHbcgg4UREZfWCOip439fA4E
         LsoQccIbooMH6I3oBljrgyoic0cSzMrliwPNcPedoz8+sg+mqGYXJLTuIN5Bcm0RX9
         QVLPR5U1qki9AeiFZHYj3Cx1t+mlEniOJJbXyxG6y60zJggaAbh70ayc3X/OvNqKg2
         QSiXoG2n1eSnw==
Date:   Mon, 31 Jul 2023 11:19:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/5] net: enetc: use EXPORT_SYMBOL_GPL for
 enetc_phc_index
Message-ID: <20230731111959.7403238c@kernel.org>
In-Reply-To: <20230731083806.453036-3-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
        <20230731083806.453036-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 31 Jul 2023 10:38:03 +0200 Christoph Hellwig wrote:
> enetc_phc_index is only used via symbol_get, which was only ever
> intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
> for it so that symbol_get can enforce only being used on
> EXPORT_SYMBOL_GPL symbols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
