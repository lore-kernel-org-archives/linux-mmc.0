Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com [45.254.49.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A53D47D9;
	Tue, 24 Mar 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341309; cv=none; b=tyOJoA7DYCLFN5aBVgXjQcqZzgy5JeCfWcvjIPC2RIpj0YK+JVtRoCesZXUxm27Sgf9PZhZCPzvWXsE6cD62wNqDihk/gZ9hxNcAPVaPlDnr9ySAV7WyvB2zX3CsFsdGa4sp9fJ+IJOWtOFO+//wXaGEMRQhq/p9uCoIykhg+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341309; c=relaxed/simple;
	bh=zOMt5oRN6NDOCXoWe5LmPLUzBwuINddbi2vsGL6I45c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dOhBqSszwsbXVW2NVaImUzHBb3GgqnpeL7jVKy0lRAUR/wxMcJ2ZQElOYbkT2Ita0IEk/w2/oUvOMLvJpjoDonEKgE9l0tLQLyUnFBQZed77CN0hXdjiErQDga5BKTFgqIca6DwpLFqB+gKb1KhKwjrT3eTB4WBgXhI/w/+ue88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=P2qm1tyq; arc=none smtp.client-ip=45.254.49.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="P2qm1tyq"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3815207a1;
	Tue, 24 Mar 2026 16:34:44 +0800 (GMT+08:00)
Message-ID: <531cc3a4-5839-f737-9db0-7f12927c2126@rock-chips.com>
Date: Tue, 24 Mar 2026 16:34:43 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map
 infrastructure
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1773713843-118137-1-git-send-email-shawn.lin@rock-chips.com>
 <dbeaa75f-7ba3-4dfe-b4e6-1395ea699d65@amd.com>
 <844991dc-870c-47aa-8a58-a83645d35029@amd.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <844991dc-870c-47aa-8a58-a83645d35029@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d1efb636a09cckunm93d2cb4b9d612d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tCT1ZOHUwaTkhCGh5CTENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=P2qm1tyqRCf7tDGP/IRRTPzJzQRbIdXh6br9vE2vXyqUAyXf5K7dLZnzG5LZSXBBTwBYRu/vW3XrgYkoi9asAOijOhf8hWVc+6y7jeWnJVL4ji+2MnHuTSolnJQ8NM8SdDtkli1UFzInQYa/C/cANnBF2mOjV7NUvP/NADIZNM4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=g8evQa6axgDPRispCo04urysKjAc9kl7W8WVmQkX/W8=;
	h=date:mime-version:subject:message-id:from;

Hi Sai

在 2026/03/23 星期一 17:27, Sai Krishna Potthuri 写道:
> 
> 
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Thursday, March 19, 2026 3:39 PM
>> To: Shawn Lin <shawn.lin@rock-chips.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>; Potthuri, Sai Krishna
>> <sai.krishna.potthuri@amd.com>
>> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] mmc: sdhci-of-arasan: Use standard
>> mmc_clk_phase_map infrastructure
>>
>> +Sai,
>>
>> On 3/17/26 03:17, Shawn Lin wrote:
>> > Convert the Arasan SDHCI driver to use the mainline standard
>> > mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
>> > arrays as well as arasan_dt_read_clk_phase().
>> >
>> > The phase values for ZynqMP, Versal, and Versal-NET platforms are
>> > still initialized from the predefined tables, but now follow the
>> > standard phase_map format with valid flag.
>> >
>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > ---
>> >
>> >   drivers/mmc/host/sdhci-of-arasan.c | 79 
>> +++++++++-----------------------------
>> >   1 file changed, 18 insertions(+), 61 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> > b/drivers/mmc/host/sdhci-of-arasan.c
>> > index caf9723..b97d27c 100644
>> > --- a/drivers/mmc/host/sdhci-of-arasan.c
>> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> > @@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
>> >    * @sdcardclk:        Pointer to normal 'struct clock' for
>> sdcardclk_hw.
>> >    * @sampleclk_hw:    Struct for the clock we might provide to a PHY.
>> >    * @sampleclk:        Pointer to normal 'struct clock' for
>> sampleclk_hw.
>> > - * @clk_phase_in:    Array of Input Clock Phase Delays for all 
>> speed modes
>> > - * @clk_phase_out:    Array of Output Clock Phase Delays for all speed
>> modes
>> > + * @phase_map:        Struct for mmc_clk_phase_map provided.
>> >    * @set_clk_delays:    Function pointer for setting Clock Delays
>> >    * @clk_of_data:    Platform specific runtime clock data storage 
>> pointer
>> >    */
>> > @@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
>> >       struct clk      *sdcardclk;
>> >       struct clk_hw    sampleclk_hw;
>> >       struct clk      *sampleclk;
>> > -    int        clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
>> > -    int        clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
>> > +    struct mmc_clk_phase_map phase_map;
>> >       void        (*set_clk_delays)(struct sdhci_host *host);
>> >       void        *clk_of_data;
>> >   };
>> > @@ -1248,37 +1246,13 @@ static void sdhci_arasan_set_clk_delays(struct
>> sdhci_host *host)
>> >       struct sdhci_arasan_data *sdhci_arasan =
>> sdhci_pltfm_priv(pltfm_host);
>> >       struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
>> >
>> > -    clk_set_phase(clk_data->sampleclk,
>> > -              clk_data->clk_phase_in[host->timing]);
>> > -    clk_set_phase(clk_data->sdcardclk,
>> > -              clk_data->clk_phase_out[host->timing]);
>> > -}
>> > -
>> > -static void arasan_dt_read_clk_phase(struct device *dev,
>> > -                     struct sdhci_arasan_clk_data *clk_data,
>> > -                     unsigned int timing, const char *prop)
>> > -{
>> > -    struct device_node *np = dev->of_node;
>> > -
>> > -    u32 clk_phase[2] = {0};
>> > -    int ret;
>> > -
>> > -    /*
>> > -     * Read Tap Delay values from DT, if the DT does not contain the
>> > -     * Tap Values then use the pre-defined values.
>> > -     */
>> > -    ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
>> > -                          2, 0);
>> > -    if (ret < 0) {
>> > -        dev_dbg(dev, "Using predefined clock phase for %s = %d
>> %d\n",
>> > -            prop, clk_data->clk_phase_in[timing],
>> > -            clk_data->clk_phase_out[timing]);
>> > +    if (!clk_data->phase_map.phase[host->timing].valid)
>> >           return;
> 
> This check breaks platforms relying on default phase values. When DT
> properties are absent, mmc_of_parse_timing_phase() sets valid=false,
> which causes sdhci_arasan_set_clk_delays() to skip phase configuration.
> 

Ah, you're right, thanks for catching this.

I'll send a v2 patch that removes the validity check in
sdhci_arasan_set_clk_delays().

> Regards
> Sai Krishna
> 
>> > -    }
>> >
>> > -    /* The values read are Input and Output Clock Delays in order */
>> > -    clk_data->clk_phase_in[timing] = clk_phase[0];
>> > -    clk_data->clk_phase_out[timing] = clk_phase[1];
>> > +    clk_set_phase(clk_data->sampleclk,
>> > +              clk_data->phase_map.phase[host->timing].in_deg);
>> > +    clk_set_phase(clk_data->sdcardclk,
>> > +              clk_data->phase_map.phase[host->timing].out_deg);
>> >   }
>> >
>> >   /**
>> > @@ -1315,8 +1289,9 @@ static void arasan_dt_parse_clk_phases(struct
>> device *dev,
>> >           }
>> >
>> >           for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>> > -            clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
>> > -            clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].in_deg =
>> zynqmp_iclk_phase[i];
>> > +            clk_data->phase_map.phase[i].out_deg =
>> zynqmp_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].valid = true;
>> >           }
>> >       }
>> >
>> > @@ -1327,8 +1302,9 @@ static void arasan_dt_parse_clk_phases(struct
>> device *dev,
>> >               VERSAL_OCLK_PHASE;
>> >
>> >           for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>> > -            clk_data->clk_phase_in[i] = versal_iclk_phase[i];
>> > -            clk_data->clk_phase_out[i] = versal_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].in_deg =
>> versal_iclk_phase[i];
>> > +            clk_data->phase_map.phase[i].out_deg =
>> versal_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].valid = true;
>> >           }
>> >       }
>> >       if (of_device_is_compatible(dev->of_node, 
>> "xlnx,versal-net-emmc"))
>> > { @@ -1338,32 +1314,13 @@ static void arasan_dt_parse_clk_phases(struct
>> device *dev,
>> >               VERSAL_NET_EMMC_OCLK_PHASE;
>> >
>> >           for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
>> > -            clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
>> > -            clk_data->clk_phase_out[i] =
>> versal_net_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].in_deg =
>> versal_net_iclk_phase[i];
>> > +            clk_data->phase_map.phase[i].out_deg =
>> versal_net_oclk_phase[i];
>> > +            clk_data->phase_map.phase[i].valid = true;
>> >           }
>> >       }
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
>> > -                 "clk-phase-legacy");
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
>> > -                 "clk-phase-mmc-hs");
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
>> > -                 "clk-phase-sd-hs");
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
>> > -                 "clk-phase-uhs-sdr12");
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
>> > -                 "clk-phase-uhs-sdr25");
>> > -    arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
>> > -                 "clk-phase-uhs-sdr50");
>> > -    arasan_dt_read_clk_phase(dev, clk_data,
>> MMC_TIMING_UHS_SDR104,
>> > -                 "clk-phase-uhs-sdr104");
>> > -    arasan_dt_read_clk_phase(dev, clk_data,
>> MMC_TIMING_UHS_DDR50,
>> > -                 "clk-phase-uhs-ddr50");
>> > -    arasan_dt_read_clk_phase(dev, clk_data,
>> MMC_TIMING_MMC_DDR52,
>> > -                 "clk-phase-mmc-ddr52");
>> > -    arasan_dt_read_clk_phase(dev, clk_data,
>> MMC_TIMING_MMC_HS200,
>> > -                 "clk-phase-mmc-hs200");
>> > -    arasan_dt_read_clk_phase(dev, clk_data,
>> MMC_TIMING_MMC_HS400,
>> > -                 "clk-phase-mmc-hs400");
>> > +
>> > +    mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
>> >   }
>> >
>> >   static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>>
>> please take a look at this patch.
>> I was talking to him yesterday and he needs to finish two things 
>> before he has
>> time to look at it. That's why please give him some time.
>>
>> Thanks,
>> Michal
> 
> 
