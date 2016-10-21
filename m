From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2] mmc: sunxi: Prevent against null dereference for vmmc
Date: Fri, 21 Oct 2016 10:52:23 +0800
Message-ID: <CAGb2v67L8MZuLYLUpiG-afOdEXTw4DtJtR7VdPUabwTNejsPmg@mail.gmail.com>
References: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 19, 2016 at 9:33 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> VMMC is an optional regulator, which means that mmc_regulator_get_supply
> will only return an error in case of a deferred probe, but not when the
> regulator is not set in the DT.
>
> However, the sunxi driver assumes that VMMC is always there, and doesn't
> check the value of the regulator pointer before using it, which obviously
> leads to a (close to) null pointer dereference.
>
> Add proper checks to prevent that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
