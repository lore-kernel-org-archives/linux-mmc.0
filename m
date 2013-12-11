From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 04:45:54 +0100
Message-ID: <201312110445.54336.arnd@arndb.de>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <201312060239.14832.arnd@arndb.de>
 <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: devicetree@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Dinh Nguyen <dinguyen@altera.com>, Kumar Gala <galak@codeaurora.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 11 December 2013, Zhangfei Gao wrote:
> Thanks for the good suggestion, it can be abstracted to clock.
> 
> The issue for this version's ip is there are some registers need to be
> set, including fixed factor and phase, which may be required to be
> tuned, however it can be hide in clock.
> 
> Double checked next version's ip, it is more intelligent and only
> fixed factor is required, more like a clock, and all these register
> accessing are NOT required.
> 
> Will update new version to abstract these chip depended registers to clock.

Ok, please stay in contact with Dinh Nguyen over this, since his side
is work-in-progress and we are still evaluating how to best encode
the phase setting in DT in a generic form.

	Arnd
