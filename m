From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc : Use wait_for_completion_timeout() instead of
 wait_for_completion in case of write.
Date: Wed, 21 Sep 2011 12:48:41 +0200
Message-ID: <CACRpkdaqFG20YU-YmWxj+M4tqrSB=wCN=HX==rFfUJnJTqajiQ@mail.gmail.com>
References: <1316359301-2263-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41139 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1IUKsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2011 06:48:42 -0400
In-Reply-To: <1316359301-2263-1-git-send-email-linkinjeon@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 18, 2011 at 5:21 PM, Namjae Jeon <linkinjeon@gmail.com> wro=
te:

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout_us +=3D mrq->da=
ta->timeout_clks * 1000 /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_ho=
st_clk_rate(host) / 1000);

The math teacher says this is equivalent to:

timeout_us +=3D (mrq->data->timeout_clks / mmc_host_clk_rate) * 1000000=
 ;

Yours,
Linus Walleij
