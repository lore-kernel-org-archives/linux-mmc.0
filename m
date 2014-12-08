From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/6] mfd: rtsx: add func to split u32 into register
Date: Mon, 8 Dec 2014 11:21:06 +0100
Message-ID: <CAPDyKFpt2yT2o159_uX+3RxxpnP=J1SotW58s220SkJSni7PHw@mail.gmail.com>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1417758564.git.micky_ching@realsil.com.cn>
 <20141208095746.GG3951@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20141208095746.GG3951@x1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 8 December 2014 at 10:57, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 05 Dec 2014, micky_ching@realsil.com.cn wrote:
>> From: Micky Ching <micky_ching@realsil.com.cn>
>>
>> Add helper function to write u32 to registers, if we want to put u32
>> value to 4 continuous register, this can help us reduce tedious work.
>>
>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  include/linux/mfd/rtsx_pci.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> Applied, thanks.

Lee,

I suppose you queued this for 3.19?

I don't intend to queue anything more before the merge window and thus
the mmc patches can later be handled without any dependence to mfd, I
guess!?

Kind regards
Uffe
