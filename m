From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/3] ARM: pxa168: Add SDHCI support
Date: Thu, 10 Nov 2011 22:14:57 -0500
Message-ID: <87aa83wdse.fsf@laptop.org>
References: <1319546069-31742-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <1320399547-2374-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <CAMPhdO9EWeXw-XsjQ5x-qcAbjFDxrdz47wirFKWKV=kJFZAKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMPhdO9EWeXw-XsjQ5x-qcAbjFDxrdz47wirFKWKV=kJFZAKiw@mail.gmail.com>
 (Eric Miao's message of "Fri, 11 Nov 2011 09:18:32 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jason.chagas@marvell.com, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 10 2011, Eric Miao wrote:
> Sorry Tanmay for late response.
>
> The problem is that I didn't seem to find sdhci-pxav1 though in drivers/mmc.

This is part of a three patch set with sdhci-pxav1 added in patch two.
We're still talking about how best to handle adding the MMC side, though.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
