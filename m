From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Tue, 07 Feb 2012 17:40:00 +0900
Message-ID: <001201cce574$14b7d220$3e277660$%jun@samsung.com>
References: <000901ccdc09$92daf020$b890d060$%jun@samsung.com>
 <m2obte86qi.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <m2obte86qi.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Namjae Jeon' <linkinjeon@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Chris Ball <cjb@laptop.org> wrote:
> Hi Seungwon,
> 
> On Thu, Jan 26 2012, Seungwon Jeon wrote:
> > This patch-set adds support of packed command feature
> > for eMMC4.5 devices.
> 
> Thanks, looks good!  Were you or Namjae able to measure any performance
> changes with this patchset applied?
We could get the difference results depending on eMMC device.
I have tested patch set with eMMC device which was not optimized in packed command.
In my environment there is a performance gain only with packed write
if total chunk size for transfer is large.
This is not common case in user scenario as of now.
Currently this patch set with regard to packed command is meaningful
and helpful for device supporting fully.

Best regards,
Seungwon Jeon.

> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
