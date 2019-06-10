From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/7] clk: actions: Fix factor clk struct member access
Date: Mon, 10 Jun 2019 08:01:59 -0700
Message-ID: <20190610150200.8A32220859@mail.kernel.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org> <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: afaerber@suse.de, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-06-08 12:53:11)
> Since the helper "owl_factor_helper_round_rate" is shared between factor
> and composite clocks, using the factor clk specific helper function
> like "hw_to_owl_factor" to access its members will create issues when
> called from composite clk specific code. Hence, pass the "factor_hw"
> struct pointer directly instead of fetching it using factor clk specific
> helpers.
>=20
> This issue has been observed when a composite clock like "sd0_clk" tried
> to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> error.
>=20
> Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

I agree with Andreas on the function name. With that change you can add

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
