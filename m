Received: from smtpcmd15177.aruba.it (smtpcmd15177.aruba.it [62.149.156.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF7199B9
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664597; cv=none; b=JyZ8Y8U/Nap0JeDfKpZEg5hK8Q/kjGDQ3Z2Mu4McxHPJ/kKLuCgyTu4sKV0bEOLbrVA1DEPdiOAPay4UsHZSJkb72VwgQ5rMsjYr3eTIMpm0QVvHQJYjPddceGmu5XiWS577GnaAZTnOlRuOUuNmw3UXcBPCqJ6TiWtZgBqZo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664597; c=relaxed/simple;
	bh=zDuRp1A1SfM57QYEyPZ7MMb4bDw03cCwGab0TfwuucI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q0VKnkdfHIN0/4x5DdfAuI9Cuej0N11poMmVcKW2kZk4Ej8N4sHVMzYFudyDDSmGhZJVQgYRYBfi6rx2b/OrA2zDWdQI32pnSXM96avxiddUFWg2WivEN7IAflmENakMhIMdyI4ydS+/BrmuU/k6viXb2omSnbRRkdxdQ4pJxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=FZWxsuZU; arc=none smtp.client-ip=62.149.156.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="FZWxsuZU"
Received: from [192.168.50.163] ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id hZoPrAC4jT8FyhZoPr4dJh; Tue, 05 Mar 2024 19:46:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1709664409; bh=zDuRp1A1SfM57QYEyPZ7MMb4bDw03cCwGab0TfwuucI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=FZWxsuZUoHNxzIIvxOe3wLgtB4o9YMMUSX60ix4IIWSpzOuwxMpNx01+z4Otof707
	 J66o9c8FyAob9mGoHspP+n2jRSlRcTbERPCTCoHEi+4b+RQQ5xg5kKJ0iElPSIrEMH
	 PFKxY0eeTQBsz3UIjv5V3VahNTOfsjkK2kXY4I9yI6/p7c1nylPBV4qiGMmhQ/vkNo
	 pkTcF7gofZlOeM8GYgIEhjaM2dUlKr+1jd6vRIzZVeg7vgZeAF4ytKfXdaxenD1IE+
	 MheEi84QZIPN+MAdpLfE9JRM22uTNOnmUoh7M8GUzXDlWa2tTCMePNDY6rkdQ9IajO
	 m0iY5ds2AUeug==
Message-ID: <9de33c0d-1fe5-4114-8e11-306db56576ed@benettiengineering.com>
Date: Tue, 5 Mar 2024 19:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Content-Language: en-US
To: Avri Altman <Avri.Altman@wdc.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20240305105949.392092-1-giulio.benetti@benettiengineering.com>
 <DM6PR04MB657512876A037D82CC78EA58FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLZyWLRVyw/Z3HR+c5W7x8eiPQJlzzNV5GajGX0OhDeFVQYlGz7Xn8doQVFIDv8dtFBGjncGcYaHTkuCQCzU2jJFq2TMBV0sJxvSqORKMUCUoVh/4Utp
 Hv767r5POk/JTV8SDvfpBnFyx49bo1R1/TSHVhept0Y8+xmesh0zcnlF3e71ZqqS/8cgKC59Ex/5n7N/ELYxsWoR/04/NrBzstKp7EgGqHSgmCe2Fq5EQ8rz
 fJjoBtRvfbQeGZn2V94Mng==

On 05/03/24 16:01, Avri Altman wrote:
>>> When building with -Werror=strict-aliasing error is thrown:
>>>
>>> mmc_cmds.c: In function 'do_ffu':
>>> mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break
>>> strict- aliasing rules [-Werror=strict-aliasing]
>>>    sect_done = htole32(*((__u32
>>> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
>>>    ^
>>> cc1: all warnings being treated as errors
>>>
>>> Let's fix type-punned breaking strict-aliasing by memcpy() the variable.
>> If any, I would just revert commit a1b594ca735e.
>>
>> Thanks,
>> Avri
> Or, how about this untested option.

This is a good solution, just re-spin and renamed to
per_byte_htole32(__u8 *). Hope it sounds good the name to you.

Thank you
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

> Thanks,
> Avri
> 
> 
> index ae7b876..10f7532 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -58,6 +58,11 @@
>   #define WPTYPE_PWRON 2
>   #define WPTYPE_PERM 3
> 
> +static inline __u32 strict_htole32(__u8 *arr)
> +{
> +       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
> +}
> +
>   int read_extcsd(int fd, __u8 *ext_csd)
>   {
>          int ret = 0;
> @@ -2807,7 +2812,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
>                                 __u8 *ext_csd, unsigned int bytes, __u8 *buf,
>                                 off_t offset)
>   {
> -       __u32 arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
> +       __u32 arg = safe_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
> 
>          /* send block count */
>          set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> @@ -2827,7 +2832,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
>   int do_ffu(int nargs, char **argv)
>   {
>          int dev_fd, img_fd;
> -       int sect_done = 0, retry = 3, ret = -EINVAL;
> +       int retry = 3, ret = -EINVAL;
>          unsigned int sect_size;
>          __u8 ext_csd[512];
>          __u8 *buf = NULL;
> @@ -2835,6 +2840,7 @@ int do_ffu(int nargs, char **argv)
>          char *device;
>          struct mmc_ioc_multi_cmd *multi_cmd = NULL;
>          unsigned int default_chunk = MMC_IOC_MAX_BYTES;
> +       __u32 sect_done = 0;
> 
>          assert (nargs == 3 || nargs == 4);
> 
> @@ -2968,7 +2974,7 @@ do_retry:
>          }
> 
>          /* Test if we need to restart the download */
> -       sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
> +       sect_done = strict_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
>          /* By spec, host should re-start download from the first sector if sect_done is 0 */
>          if (sect_done == 0) {
>                  if (retry--) {

