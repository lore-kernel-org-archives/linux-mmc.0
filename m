From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 0/5] mmc: add double buffering for mmc block requests
Date: Tue, 18 Jan 2011 09:12:24 +0100
Message-ID: <AANLkTimjfO4Wb0f87X_sDugW=yU1=YEQn35uZnsKKwq2@mail.gmail.com>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
	<4D34FC5D.5080605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56693 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1ARIMZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 03:12:25 -0500
In-Reply-To: <4D34FC5D.5080605@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On 18 January 2011 03:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Per..
>
> it is interesting approach..so
> we want to test your double buffering in our environment(Samsung SoC).
>
> Did you test with SDHCI?
So far I have only tested on mmci for board u5500 and u8500. I happily
test on a different board if I can get hold of one.

> If you tested with SDHCI, i want to know how much increase the performance.
>
> Thanks,
> Jaehoon Chung
