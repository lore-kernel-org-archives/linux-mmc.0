From: "S. Gilles" <sgilles@math.umd.edu>
Subject: [BUG] Boot failure since df9bcc2bc on veyron_speedy
Date: Mon, 9 Jan 2017 09:19:55 -0500
Message-ID: <20170109141955.GB13205@number18.npnth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I have a C201, a veyron_speedy device (which uses rk3288) running vanilla
kernels. With recent kernels it will fail to boot (screen is on, with
blinking cursor, but no login prompt and the machine does not respond
over ssh).

I've bisected this to df9bcc2bc0a1f8d2963bd916698268fb2470713b, and
reverting that commit on -mainline gives me a bootable kernel. I can
provide more information as needed.

Thanks,
S. Gilles
