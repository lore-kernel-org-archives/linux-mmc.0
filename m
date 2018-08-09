From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Date: Thu, 9 Aug 2018 15:44:12 +0300
Message-ID: <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
        <20180809122706.GT21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809122706.GT21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 9 Aug 2018 14:27:06 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> > Register a pinctrl device and implement get and set functions for
> > PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 185 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c  
> [...]
> > @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] = {
> >  		.name	= (_name),			\
> >  	})
> >  
> > +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> > +	((struct pinctrl_pin_desc) {			\
> > +		.number = (_id),			\
> > +		.name	= (_name)			\
> > +	})
> > +  
> 
> Do we really need the explicit cast to struct pinctrl_pin_desc here?
> 

No, but I prefer to have it as it makes the type of the value the macro
expands to explicit. In a way it hints at how and where the macro should
be used and arguably improves readability.

 -Aapo
