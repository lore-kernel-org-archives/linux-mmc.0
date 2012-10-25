From: Yuvaraj CD <yuvaraj.lkml@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: enable controller interrupt before calling mmc_start_host
Date: Thu, 25 Oct 2012 15:39:50 +0530
Message-ID: <CA+NduCBvB6kx3ZGhrUTiRJ4hTY4a0NV4Q8GYeBYWGvzTM=ccEQ@mail.gmail.com>
References: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
	<87hapkhoor.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87hapkhoor.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Yuvaraj CD <yuvaraj.cd@gmail.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, will.newton@imgtec.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, thomas.abraham@linaro.org, patches@linaro.org, Yuvaraj CD <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Yes,its legal name."Yuvaraj C D".

On Wed, Oct 24, 2012 at 2:49 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Oct 08 2012, Yuvaraj CD wrote:
>> As mmc_start_host is getting called before enabling the dw_mmc controller
>> interrupt, there is a problem of missing the SDMMC_INT_CMD_DONE for the
>> very first command sent by the sdio_reset.
>> This problem occurs only when we disable MMC debugging i.e, MMC_DEBUG [=n].
>> Hence this patch enables the dw_mmc controller interrupt before mmc_start_host.
>>
>> Signed-off-by: Yuvaraj CD <yuvaraj.cd@samsung.com>
>
> Is "Yuvaraj CD" your legal name?  We should use your full name so that
> we can track copyright attribution properly.
>
> Thanks!
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
