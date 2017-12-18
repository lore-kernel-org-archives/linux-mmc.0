From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: tmio: use ioread* for repeated access to a register
Date: Mon, 18 Dec 2017 14:01:24 +0100
Message-ID: <CAPDyKFr5A7Qma_Ef5JMjvG1f_Er+f9K-tnj39_q0Wg2aQ7nY5w@mail.gmail.com>
References: <20171218000021.16655-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218000021.16655-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 18 December 2017 at 01:00, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Not all archs define reads* and writes*. Switch to ioread*_rep and
> friends which is defined everywhere, so we can enable COMPILE_TEST after
> that.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

I put the patch in front of Yamada-san's patch that made it possible
to use COMPILE_TEST. Thus avoiding breaking bisecting.

> ---
>
> So, I pushed this to buildbot on top of Yamada-san's patch series and there
> were no complaints, even with COMPILE_TEST enabled. I also did some tests on
> HW and checksuming huge files on SD cards still works.
>
> However, I am not sure about this mixture of read* and ioread* functions. Shall
> we convert maybe all of those?

Yes, seems like a good idea.

[...]

Kind regards
Uffe
