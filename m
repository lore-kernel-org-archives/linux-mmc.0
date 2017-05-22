From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] of/platform: Make of_platform_device_destroy
 globally visible
Date: Mon, 22 May 2017 08:30:58 -0500
Message-ID: <CAL_JsqK=Ss43c-3886pFc3HcbNtOT_15GvmoYOLEZ-M7PW3C8A@mail.gmail.com>
References: <20170522110921.15395-1-jglauber@cavium.com> <20170522110921.15395-3-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522110921.15395-3-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 22, 2017 at 6:09 AM, Jan Glauber <jglauber@cavium.com> wrote:
> of_platform_device_destroy is the counterpart to
> of_platform_device_create which is a non-static function.
>
> After creating a platform device it might be neccessary
> to destroy it to deal with -EPROBE_DEFER where a
> repeated of_platform_device_create call would fail otherwise.
>
> Therefore also make of_platform_device_destroy globally visible.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/of/platform.c       | 3 ++-
>  include/linux/of_platform.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
