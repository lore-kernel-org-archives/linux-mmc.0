Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DBEC433E6
	for <linux-mmc@archiver.kernel.org>; Sat, 13 Mar 2021 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B84664EDA
	for <linux-mmc@archiver.kernel.org>; Sat, 13 Mar 2021 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhCMW25 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhCMW2r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 13 Mar 2021 17:28:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B439E64EC9;
        Sat, 13 Mar 2021 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615674526;
        bh=hkGtcFlmjgJ9aLvEP89qMThzrWX8g5ulPeS+tirCwK0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NGkZcSfYD0QU1glfvKhxLqAtzWckGUH2pSN0IeCYfb6qHU8j0RK1PLm0bODtQViDa
         4/t9M0CXMU9G72nWYnHm4wdF9fr51x7yYjG0q5FxS97SZEDy363YEpdtKYAXPg5wxv
         T1wLomGfogUqUDt7cfjhdQ5k3GpD9ywywQF+D76CSyQNqA3S6SBhHxUtN0ioNnK0Ih
         Kp3aLFEvNfNLAAv/ujkore9TXPLFOyWk+IpKGZhTt+ci6DJ+J8sAMJhT8vLY/xLIm9
         F1jRuPqh3ttRT9exab7gTkv/E95Y0uiLm/x23QSUaFgnwlf4m9ClI65h9XbocCtLHq
         KDWIQzD1VN3tA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210307170742.70949-2-paul@crapouillou.net>
References: <20210307170742.70949-1-paul@crapouillou.net> <20210307170742.70949-2-paul@crapouillou.net>
Subject: Re: [PATCH 1/2] clk: Add clk_get_first_to_set_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 13 Mar 2021 14:28:45 -0800
Message-ID: <161567452539.1478170.2985873696192051312@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Paul Cercueil (2021-03-07 09:07:41)
> The purpose of this function is to be used along with the notifier
> mechanism.
>=20
> When a parent clock can see its rate externally changed at any moment,
> and a driver needs a specific clock rate to function, it can register a
> notifier on the parent clock, and call clk_set_rate() on the base clock
> to adjust its frequency according to the new parent clock.

Can the driver use the rate locking mechanism to get a certain rate
instead of registering for notifiers and trying to react to changes?

>=20
> This works fine, until the base clock has the CLK_SET_RATE_PARENT flag
> set. In that case, calling clk_set_rate() on the base clock will call
> clk_set_rate() on the parent clock, which will trigger the notifier
> again, and we're in a loop.
>=20
> For that reason, we need to register the notifier on the parent clock of
> the first ancestor of the base clock that will effectively modify its
> rate when clk_set_rate() is called, which we can now obtain with
> clk_get_first_to_set_rate().
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
