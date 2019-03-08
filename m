From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 6/6] mmc: mmci: replace blksz_datactrlXX by
 get_datactrl_cfg callback
Date: Fri, 8 Mar 2019 09:44:40 +0100
Message-ID: <eb213e3e-a574-b11e-ad4f-dd270d964707@st.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
 <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
 <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

hi Russell, Ulf

On 3/7/19 5:46 PM, Russell King - ARM Linux admin wrote:
> On Thu, Mar 07, 2019 at 05:39:02PM +0100, Ludovic Barre wrote:
>> -	if (data->flags & MMC_DATA_READ)
>> -		datactrl |= MCI_DPSM_DIRECTION;
> 
> Given that this is currently an invariant between all, it doesn't make
> sense to have a separate public function and combine it into the
> get_datactrl_cfg() implementations.  You may as well leave it in place
> here, after you call get_datactrl_cfg().
> 
>> +	datactrl = host->ops->get_datactrl_cfg(host);
> 
> Otherwise, I don't see a problem with this, although it would be nice to
> avoid the overhead of so many public functions, which could be done by
> adding them as inline functions in mmci.h
> 

To combine your comments (above and https://lkml.org/lkml/2019/3/6/318).
I could regroup mmci_dctrl_dir & mmci_dctrl_ddr & mmci_dctrl_sdio in a
common function mmci_dctrl_common and call by:
-Each get_datactrl_cfg variant
-Or in mmci_start_data

What do you prefer ?

Regards,
Ludo
