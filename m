From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 1/7] clk: actions: Fix factor clk struct member access
Date: Tue, 17 Sep 2019 22:06:28 +0530
Message-ID: <20190917163628.GA2615@Mani-XPS-13-9360>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-2-manivannan.sadhasivam@linaro.org>
 <20190917163419.4C4DD20665@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190917163419.4C4DD20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: afaerber@suse.de, robh+dt@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 09:34:18AM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-09-16 08:45:40)
> > Since the helper "owl_factor_helper_round_rate" is shared between factor
> > and composite clocks, using the factor clk specific helper function
> > like "hw_to_owl_factor" to access its members will create issues when
> > called from composite clk specific code. Hence, pass the "factor_hw"
> > struct pointer directly instead of fetching it using factor clk specific
> > helpers.
> > 
> > This issue has been observed when a composite clock like "sd0_clk" tried
> > to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> > error.
> > 
> > While we are at it, let's rename the "clk_val_best" function to
> > "owl_clk_val_best" since this is an owl SoCs specific helper.
> > 
> > Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> 
> I can apply this to clk-next?

Yes, please :-) Rest can go through Ulf's tree.

Thanks,
Mani

> 
