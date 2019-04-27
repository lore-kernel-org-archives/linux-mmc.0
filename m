From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date: Sat, 27 Apr 2019 22:02:25 +0200
Message-ID: <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-5-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-5-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jerome,

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> been unsuccessful or unreliable. Until we can figure out how to enable this
> mode safely and reliably, let's force it off.
last year I have seen issues with HS400 on my Khadas VIM2: [0]
have you tested all other patches from this series and HS400 is still
not working for you?

I'm curious because this patch is early in the series and all the
tuning fixes and improvements are after this patch.


Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006251.html
