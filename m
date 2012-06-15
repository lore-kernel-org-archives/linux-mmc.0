From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/2] regulator: core.c Only delay when setting voltage
 requires this
Date: Fri, 15 Jun 2012 19:19:57 +0800
Message-ID: <CAF+7xWnXL_2AvZ_5TR+fa-yMOf6qbK+m8p3pkPJQVbHzPw-zhg@mail.gmail.com>
References: <1339711676-3488-1-git-send-email-prakity@marvell.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339711676-3488-1-git-send-email-prakity@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Rakity <philipspatches@gmail.com>
Cc: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>
List-Id: linux-mmc@vger.kernel.org

2012/6/15 Philip Rakity <philipspatches@gmail.com>:
> minor optimization: move delay code to where delay is set and
> thus where it is used vs in the main line path.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
Acked-by: Axel Lin <axel.lin@gmail.com>
