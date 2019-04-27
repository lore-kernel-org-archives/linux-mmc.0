From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/7] mmc: meson-gx: ack only raised irq
Date: Sat, 27 Apr 2019 21:53:57 +0200
Message-ID: <CAFBinCDb8H74=awtuu2Z0MDF47gXbi2AVPAHNXfz=S8xVT0J8g@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 23, 2019 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> This is merely a clean up. It makes sense to only ack raised irqs
> instead of acking everything all the time.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
based on reading (and understanding) the code and a test on my Khadas
VIM this seems fine so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
