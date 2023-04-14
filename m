Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A5C77B70
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Apr 2023 05:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNFgW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNFgU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Apr 2023 01:36:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B19212E;
        Thu, 13 Apr 2023 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRTGwVe+BuUv8jF7DArKiuekjI9DUkTATKmlzMyZTfA=; b=nrk6/e09iUW5G+UDLRUQbS4Bva
        WSC95qrROjyLZvpzRZGHnyI3fslpvcEeEvgIQJOwCDaaM5Z1paZl/66aielAHLZizRk05yhvZU6GB
        t7A39z0G7YZYOaaSvcTADW6SKnEmRm2u5eSnC/ZbTgsr8MZAO5m7CAVV2DW8W9CsR0VMfRDHXOp4H
        flgebxVTCEAAD95iAYo1p+YAP927RkJlk6qnfF7x+BX/U2u1CR6gwXDMjaU31P+gmbxBuH9L4jDv6
        neAET3I3eeseoffmprho1RBtobrDQKBmpxwvPdwZmzHd8U394kWdE2Hyje4//NlZW+B4t3gfth55U
        t7CfAUPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnC6Y-008Nmo-2d;
        Fri, 14 Apr 2023 05:36:14 +0000
Date:   Thu, 13 Apr 2023 22:36:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Bhaskar Valaboju (QUIC)" <quic_bhaskarv@quicinc.com>,
        "Sachin Gupta (QUIC)" <quic_sachgupt@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Message-ID: <ZDjmTi1+WA2BtLct@infradead.org>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <ZCux+gsR8Nz4Epxw@infradead.org>
 <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

You don't get it.  There is no such thing "as vendor files".

I'm not sure where you get your terminology from, but whatever that is
might be your source of the fundamental misunderstanding how Linux
kernel development works.  I would recommend to take some training
before wasting everyones time.

