From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/6] mmc: meson-gx-mmc: Fix platform_get_irq's error checking
Date: Wed, 06 Dec 2017 16:55:08 -0800
Message-ID: <7hfu8nmk5v.fsf@baylibre.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1510950502-22565-2-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510950502-22565-2-git-send-email-arvind.yadav.cs@gmail.com>
        (Arvind Yadav's message of "Sat, 18 Nov 2017 01:58:17 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ulf.hansson@linaro.org, carlo@caione.org, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
