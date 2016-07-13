From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Print proper voltage on error
Date: Wed, 13 Jul 2016 09:55:35 +0200
Message-ID: <5785F3F7.6060708@samsung.com>
References: <1468332502-28016-1-git-send-email-k.kozlowski@samsung.com>
 <CGME20160712140926epcas1p48680eebdc43dc79797d75a04f77d4816@epcas1p4.samsung.com>
 <1468332502-28016-2-git-send-email-k.kozlowski@samsung.com>
 <57859AF4.1020204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <57859AF4.1020204@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 07/13/2016 03:35 AM, Jaehoon Chung wrote:
> Hi Krzysztof,
> 
> On 07/12/2016 11:08 PM, Krzysztof Kozlowski wrote:
>> The commit 97f659a2e972 ("mmc: dw_mmc: prevent to set the wrong
>> value") reordered the code so the 'uhs' variable used in
>> mmc_regulator_set_vqmmc() error message is always 0 at that time thus
>> always printing 3.3 voltage.  Instead use value obtained from ios in
>> printed error message.
> 
> The commit 97f659a2e972 was dropped because some board didn't work fine.
> Some boards didn't use the vqmmc suppy and not defined into device-tree.
> 
> It's short time to fix. I will re-send the patch on next.
> At that time, i will check this patch.

Ah, okay. If 97f659a2e972 is dropped, there is no need for this patchset.

Best regards,
Krzysztof
