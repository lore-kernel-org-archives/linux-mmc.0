From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-spear: fix possible null dereference
Date: Mon, 18 Nov 2013 09:53:21 +0530
Message-ID: <CAOh2x=ku3NortOuBy0OVsZn017bCwrUOans1RF8ehF4k_PeY6w@mail.gmail.com>
References: <1384712421-10632-1-git-send-email-geyslan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:58130 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3KREXY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Nov 2013 23:23:24 -0500
In-Reply-To: <1384712421-10632-1-git-send-email-geyslan@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Geyslan G. Bem" <geyslan@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "open list:SECURE DIGITAL HO..." <spear-devel@list.st.com>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sun, Nov 17, 2013 at 11:50 PM, Geyslan G. Bem <geyslan@gmail.com> wrote:
> Put the 'pdata->card_int_gpio' assignment in inner scope, avoiding
> explicit null dereference.
>
> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
> ---
>  drivers/mmc/host/sdhci-spear.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks.
