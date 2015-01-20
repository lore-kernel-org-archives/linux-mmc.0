From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/6] mfd: rtsx: add func to split u32 into register
Date: Tue, 20 Jan 2015 22:37:53 +0100
Message-ID: <CAPDyKFo9BrfRay=HqY4cNJjmDJ+v_kzieoo7SrD+wxJp7BSG5Q@mail.gmail.com>
References: <cover.1419297154.git.micky_ching@realsil.com.cn>
	<17ba65f4bdf4707bdf038e407ecf5dc012bca281.1419297154.git.micky_ching@realsil.com.cn>
	<20150120144713.GV13701@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150120144713.GV13701@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

On 20 January 2015 at 15:47, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 23 Dec 2014, micky_ching@realsil.com.cn wrote:
>
>> From: Micky Ching <micky_ching@realsil.com.cn>
>>
>> Add helper function to write u32 to registers, if we want to put u32
>> value to 4 continuous register, this can help us reduce tedious work=
=2E
>>
>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  include/linux/mfd/rtsx_pci.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> Applied, thanks.

This one has already been queued by you, for 3.19, and it's in Linus tr=
ee. :-)

=46or your reference, I have queued the mmc patches which depends on
$subject patch for 3.20.

Kind regards
Uffe


>
>> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_p=
ci.h
>> index 74346d5..9234449 100644
>> --- a/include/linux/mfd/rtsx_pci.h
>> +++ b/include/linux/mfd/rtsx_pci.h
>> @@ -558,6 +558,7 @@
>>  #define SD_SAMPLE_POINT_CTL          0xFDA7
>>  #define SD_PUSH_POINT_CTL            0xFDA8
>>  #define SD_CMD0                              0xFDA9
>> +#define   SD_CMD_START                       0x40
>>  #define SD_CMD1                              0xFDAA
>>  #define SD_CMD2                              0xFDAB
>>  #define SD_CMD3                              0xFDAC
>> @@ -967,4 +968,12 @@ static inline u8 *rtsx_pci_get_cmd_data(struct =
rtsx_pcr *pcr)
>>       return (u8 *)(pcr->host_cmds_ptr);
>>  }
>>
>> +static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 re=
g, u32 val)
>> +{
>> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 24)=
;
>> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 16)=
;
>> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 8);
>> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val);
>> +}
>> +
>>  #endif
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
