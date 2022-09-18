Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C4ECAAD8
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIRQFm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIRQFl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 12:05:41 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73DDE18B05
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 09:05:38 -0700 (PDT)
Received: from [192.168.50.173] ([146.241.46.240])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZwnXov5OosT4eZwnXog8x3; Sun, 18 Sep 2022 18:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663517136; bh=ztzk/bfV1z/MMAwmrahPoOmB4jBAMP3uMAyf4EA2rTU=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=cssN4LHuy70i3/ps0+M/dBWmUb7L92+btHquluagnRHV2fKnC7r0gl6g0o8I6HTtk
         oGUcL7AXAP951AnRLgqZ7xm/jBaq8Ufjh/PV9D5oxoCtVRqaNk6ns7rYmlyuRzqEcA
         FFJxTHKv8sVOKpbWLoyRvd2QqAyNYdX5nxhUQlY0bE6HHaj1mkVKyB41gNDoRRjgUr
         L5RwU3FQepROklYJncw0TfRMVN+GTZ107d6dvCl9tqTdTzYPQYzF2cNeWiHLiHA5gn
         0LubfDIEnsZDvd75uL8Q23EcQ6HOnvfz03fOuA5g5zvB35cbbHHQxT7aRLFk30NOIa
         id9iVxPNhd2ow==
Message-ID: <8acecb5c-238e-e992-99f4-2f7089ee3c52@benettiengineering.com>
Date:   Sun, 18 Sep 2022 18:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] mmc-utils: mmc_cmds.c: fix warning on uninitialized
 'cnt'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
References: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
 <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEP8ty67nkSMapwNOcM3XfkCcfkMMnOsO56IyQ5MTUOHeqMYnmehz7hzqrjNQGY14otTkG3WnvZ5vGE/SmI4Sy0+eiQ/BlYAFxiGSq7Fa1Qu81BfyzPL
 gpcNQwE9I2qiz/qJFjAcv2Z2fPZj323XRLd+ruy9vR4Vie0pxUvGE4dxE4JUarSvIn7KpCnc9eAdzIri2ruwMAqjLwuorhVNwcqhUu2tdsdIsYiMrSFKft8x
 wmETRDrca5HLac/KzuyXCV6zW1bEv6/X7KNYh/boTyc=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Arnd,

On 18/09/22 16:13, Arnd Bergmann wrote:
> On Sun, Sep 18, 2022, at 2:42 PM, Giulio Benetti wrote:
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>> V1->V2:
>> * prefix subjet with 'mmc-utils:' as pointed by Avri Altman
>> ---
>>   mmc_cmds.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 12b7802..777d649 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>>   	int ret, dev_fd, key_fd, data_fd;
>>   	unsigned char key[32];
>>   	uint16_t addr;
>> -	unsigned int cnt;
>> +	unsigned int cnt = 0;
>>   	struct rpmb_frame frame_in = {
>>   		.req_resp    = htobe16(MMC_RPMB_WRITE),
>>   		.block_count = htobe16(1)
> 
> I think this is the wrong place to initialize it, I would
> suggest doing it inside of rpmb_read_counter() when returning
> an error, to make it clear that this is not the intended
> counter but something that is not actually meant to be used.
> 
> If you initialize local variables to bogus values, you remove
> the possibility for the compiler to warn a function actually uses
> something without initialization.

Totally right, thank you.

-- 
Giulio Benetti
Benetti Engineering sas
