From: =?gb2312?B?vrTI8Q==?= <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 2/2] mmc: rtsx: add support for sdio card
Date: Fri, 28 Nov 2014 01:57:22 +0000
Message-ID: <5477D682.30107@realsil.com.cn>
References: <cover.1417056337.git.micky_ching@realsil.com.cn>
 <671243677462065a8eb515d654c8a269ce73409c.1417056337.git.micky_ching@realsil.com.cn>
 <20141127154332.GB4860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20141127154332.GB4860@mwanda>
Content-Language: zh-CN
Content-ID: <9950A8276D5FAC47AD7AD1D5DCB680C7@realsil.com.cn>
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


On 11/27/2014 11:43 PM, Dan Carpenter wrote:
>> +	int stat_idx = sd_status_index(rsp_type);
> I have always hated this terrible pointer math.  5 is relative to
> pcr->host_cmds_ptr + 1.  It's a mess...
5 mean CRC7 offset of Response R1, see SD spec V3.01 Page 82.
4.9.1 R1 (normal response command).

And we have to +1 to skip unused/undefined data.
