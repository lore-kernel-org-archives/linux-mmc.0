From: =?gb2312?B?vrTI8Q==?= <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 1/2] mfd: rtsx: add func to split u32 into register
Date: Fri, 28 Nov 2014 09:54:07 +0000
Message-ID: <5478463F.9030101@realsil.com.cn>
References: <cover.1417056337.git.micky_ching@realsil.com.cn>
 <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
 <20141127152342.GA4860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20141127152342.GA4860@mwanda>
Content-Language: zh-CN
Content-ID: <A3BD4FDE1930DE44B85B16E7A2BA8615@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?gb2312?B?zfXsvw==?= <wei_wang@realsil.com.cn>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "rogerable@realtek.com" <rogerable@realtek.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Let's take an example,

cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;

using "TP" name test_pattern for simplication ,
when we call: rtsx_pci_write_be32(pcr, SD_CMD1, cmd->arg);
we should make sure TP write to SD_CMD4.

If on "be" platform, then cpu_to_be32() do nothing,
and TP is write to SD_CMD1, in this case, it is wrong.

BR,
micky.
On 11/27/2014 11:23 PM, Dan Carpenter wrote:
> On Thu, Nov 27, 2014 at 10:53:58AM +0800, micky_ching@realsil.com.cn wrote:
>> +static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 reg, u32 val)
>> +{
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 24);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 16);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 8);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val);
> This assumes the cpu is little endian.  First convert to big endian
> using cpu_to_be32() and then write it out.
>
> 	__be32 be_val = cpu_to_be32()
>
> 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, be_val);
> 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, be_val >> 8);
> 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, be_val >> 16);
> 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, be_val >> 24);
>
> (Written hurredly in my mail client.  May be wrong).
>
>> +}
>> +
>> +static inline void rtsx_pci_write_le32(struct rtsx_pcr *pcr, u16 reg, u32 val)
>> +{
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 8);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 16);
>> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val >> 24);
>> +}
> We don't have a user for rtsx_pci_write_le32() so don't add it.
>
> regards,
> dan carpenter
