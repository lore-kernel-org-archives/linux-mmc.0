From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/5] Documentation: synopsys-dw-mshc: add binding for fifo
 quirks
Date: Tue, 25 Oct 2016 11:16:52 +0900
Message-ID: <39dbfa10-03fc-0f8b-c947-0f8da5dae60b@samsung.com>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
 <1477300316-1420-4-git-send-email-jun.nie@linaro.org>
 <CGME20161024121937epcas1p3f78185f24e1bcfad677ed5971d91e1fa@epcas1p3.samsung.com>
 <02e88f2e-d87b-c999-a148-65cfe5cf84d0@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48589 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbcJYCQz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 22:16:55 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OFK000JUZNCJ000@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Oct 2016 11:16:53 +0900 (KST)
In-reply-to: <02e88f2e-d87b-c999-a148-65cfe5cf84d0@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jason.liu@linaro.org, linux-mmc@vger.kernel.org

On 10/24/2016 09:19 PM, Shawn Lin wrote:
> On 2016/10/24 17:11, Jun Nie wrote:
>> Add fifo-addr-override property and fifo-watermark-quirk property to
>> synopsys-dw-mshc bindings. It is intended to provide workarounds to
>> support more SoCs that break current assumption.
>>
>> See Documentation/devicetree/bindings/reset/reset.txt for details.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 4e00e85..eb64921 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -76,6 +76,17 @@ Optional properties:
>>
>>  * broken-cd: as documented in mmc core bindings.
>>
>> +* fifo-addr-override: Override fifo address with value provided by DT. The FIFO
>> +  reg offset of version 0x210A break current assumption that 0x100 (version < 0x240A)
>> +  and 0x200(version >= 0x240A) in some implementation. So this property serves as
>> +  workaround.
> 
> Can we hardcode this to the code by checking the host version?

I think it should be not workaround..According to TRM, Address is equal or greater than 0x100.
It means address can be 0x200, right?
If you needs to overwrite the DATA register offset for your target, just can add the property for this.

> 
>> +
>> +* fifo-watermark-quirk: Data done irq is expected if data length is less than
>> +  watermark in PIO mode. But fifo watermark is requested to be aligned with data
>> +  length in some SoC so that TX/RX irq can be generated with data done irq. Add the
>> +  watermark quirk to mark this requirement and force fifo watermark setting
>> +  accordingly.
> 
> I would like to know if this limitation is *really* related to some
> Socs or the version of 210A dw_mmc?
> 
> 
>> +
>>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>>    specified we'll defer probe until we can find this regulator.
>>
>> @@ -103,6 +114,8 @@ board specific portions as listed below.
>>          interrupts = <0 75 0>;
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>> +        fifo-addr-override = <0x200>;
>> +        fifo-watermark-quirk;
>>      };
>>
>>  [board specific internal DMA resources]
>>
> 
> 

