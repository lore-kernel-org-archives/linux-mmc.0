From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/7] mmc: meson-gx: remove open coded read with timeout
Date: Thu, 18 Apr 2019 22:18:26 +0200
Message-ID: <CAFBinCBM4r5qxhk9rBH0aqdHSg76hyNMOi9aAJG-hGJDHY-4Ow@mail.gmail.com>
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417204355.469-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is already a function available to poll a register until a
> condition is met. Let's use it instead of open coding it.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

and on my Khadas VIM with patches 1-4 from this series applied:
Tested-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
