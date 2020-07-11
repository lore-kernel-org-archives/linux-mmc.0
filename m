Return-Path: <SRS0=CJus=AW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822D5C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Jul 2020 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C8207DD
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Jul 2020 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594484173;
	bh=+BSGlLJBW8PWM3+BVUVf02ZgKAnl9LalQ3SOruYoT0c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=npdmocys1XEAInhOJhrx6aRS++6hELtHMJsAlwHhQ1MgwYFIgFW1cuzL2+f06sgFh
	 N9QkB4CMif9QonspRlXcXPLA4pdr7V8DShYjIgx3hiACHAUH4NIVRPfsrUljflHrCi
	 yD1JVV2EclP45vHwPKZqHJqckKoiwKw6Tp8R+AUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGKQQM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgGKQQM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Jul 2020 12:16:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F5F2075F;
        Sat, 11 Jul 2020 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594484172;
        bh=+BSGlLJBW8PWM3+BVUVf02ZgKAnl9LalQ3SOruYoT0c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KYzV8/ZHzQUxOw0I+CMVF1wiT7uZvnhyd5eD8mS4uTYghTKVvoI1GyIKVUC5Xsr9w
         hxDLexH9X30DWfBvlRbOmueols7wGfzk83ckeBTFqoqPdjxkSV7VkCQc5YavKKQX6I
         pbm6ixyLjgSmjs1abybkS1DG68Ot/UF/1b2oLr8Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709195706.12741-2-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-2-eajames@linux.ibm.com>
Subject: Re: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        mturquette@baylibre.com, eajames@linux.ibm.com
To:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org
Date:   Sat, 11 Jul 2020 09:16:11 -0700
Message-ID: <159448417133.1987609.8669229169177662950@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Eddie James (2020-07-09 12:57:05)
> The EMMC clock can be derived from either the HPLL or the MPLL. Register
> a clock mux so that the rate is calculated correctly based upon the
> parent.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-fixes
