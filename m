From: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
Subject: RE: A MMC card transfer issue
Date: Thu, 27 Jan 2011 10:00:09 +0900
Message-ID: <629816F753974155B62FF8FA718A26CA@hacdom.okisemi.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com> <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com> <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com> <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com> <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com> <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com> <4C4E7DE5-7CF1-4D97-9CAD-F600FCBE477A@marvell.com> <20110119174233.GA30494@void.printf.net> <F6E8C422FB8A4D78A5BDF7B6ECDA1E00@hacdom.okisemi.com> <D8E7AFC5-6B9E-414E-81A8-292FCD2F6E3C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D8E7AFC5-6B9E-414E-81A8-292FCD2F6E3C@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Philip Rakity' <prakity@marvell.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kmpark@infradead.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.chih.howe.khor@intel.com, kok.howg.ewe@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Philip,

On Thursday, January 27, 2011 12:42 AM, Philip Rakity wrote:
> Did you define the CAP for BUS WIDTH ? 
> 
> MMC_CAP_BUS_WIDTH_TEST 
> 
> in the driver or the platform driver ?

Let me make the above meaning clear.

I don't modify kernel source code "drivers/mmc" at all
Is the above mean I must modify something kernel source code ?

Thanks,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.
