From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: remove incorrect __exit_p()
Date: Mon, 26 Jan 2015 12:50:06 -0800
Message-ID: <CAD=FV=XpQ41VgjWTmuByTSo0Oa2Z0tm2eeNYFpSFLdufUrpOPw@mail.gmail.com>
References: <20150124003009.GA14891@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150124003009.GA14891@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chris Ball <chris@printf.net>, Addy Ke <addy.ke@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Dmitry,

On Fri, Jan 23, 2015 at 4:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> dw_mci_pltfm_remove() is not (nor should it be) marked as __exit,
> so we should not be using __exit_p() wrapper with it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch, thanks!

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
