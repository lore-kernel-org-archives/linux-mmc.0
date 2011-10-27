From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 22:33:36 +0200
Message-ID: <CAAgDR1Pa1pJt3ztsoXXW7KUuL7qr9zNs3N35pYNccymDE1hmng@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
	<CAH9JG2XxiYmNY684e+uZaSnJs43n+9n8r9q-wiUSjE-3P1BhhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34208 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362Ab1J0Udh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 16:33:37 -0400
Received: by gyb13 with SMTP id 13so3008092gyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 13:33:36 -0700 (PDT)
In-Reply-To: <CAH9JG2XxiYmNY684e+uZaSnJs43n+9n8r9q-wiUSjE-3P1BhhQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>

> > Just found this bit is one time programmable, so that is to
> > say this bit is not suitable for driver to change.
> You mean require the BKOPS_EN_FORCE config if user want to use at kernel?

What do you refer to when you write BKOPS_EN_FORCE config? It doesn't
seem like the OPs patch contains such a config.

 / Sebastian
