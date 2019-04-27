From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 5/7] mmc: meson-gx: avoid clock glitch when switching
 to DDR modes
Date: Sat, 27 Apr 2019 22:03:28 +0200
Message-ID: <CAFBinCAoXx2H14GEth9HkDPjbdB=XEkL8KNcFY6vUwH+YV9Aiw@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-6-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-6-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Activating DDR in the Amlogic mmc controller, among other things, will
> divide the output clock by 2. So by activating it with clock on, we are
> creating a glitch on the output.
>
> Instead, let's deal with DDR when the clock output is off, when setting
> the clock.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[boot-tested on Khadas VIM and no obvious regressions could be seen]
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for fixing this issue from v1!
