From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: check devm_kasprintf for failure
Date: Thu, 22 Nov 2018 22:45:29 +0100
Message-ID: <CAFBinCBEU336qqWnCvCVDuJ8ffOaXK5-jnUM0fuabdnmq8ZvWQ@mail.gmail.com>
References: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hofrat@osadl.org
Cc: ulf.hansson@linaro.org, khilman@baylibre.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, carlo@caione.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 22, 2018 at 10:41 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for the patch!
I tested the non-error case on my Odroid-C1 and it still works fine.


Regards
Martin
