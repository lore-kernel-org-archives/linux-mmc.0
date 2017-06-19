From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH][mmc-next] mmc: sdhci-pci: make guid intel_dsm_guid static
Date: Mon, 19 Jun 2017 12:24:08 +0200
Message-ID: <CAPDyKFqFj8h=FDvB4GmtnZEUMpW5ojH0bSu71BUybOk3U+ebDg@mail.gmail.com>
References: <20170613131426.8132-1-colin.king@canonical.com> <f9b36c7a-1c69-d825-2bc2-ccb986ab2b22@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9b36c7a-1c69-d825-2bc2-ccb986ab2b22@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Colin King <colin.king@canonical.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 June 2017 at 08:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 13/06/17 16:14, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The guid intel_dsm_guid does not need to be in global scope, so make
>> it static.
>>
>> Cleans up sparse warning:
>> "symbol 'intel_dsm_guid' was not declared. Should it be static?"
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> But this patch is dependent on the guid changes which are not in the mmc
> tree.  It's in a tree of Christoph's I think.

Right, in such case maybe Christoph can pick this up?

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 3c02c5b394d6..f1d8385d91f0 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -404,7 +404,7 @@ struct intel_host {
>>       bool    d3_retune;
>>  };
>>
>> -const guid_t intel_dsm_guid =
>> +static const guid_t intel_dsm_guid =
>>       GUID_INIT(0xF6C13EA5, 0x65CD, 0x461F,
>>                 0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
