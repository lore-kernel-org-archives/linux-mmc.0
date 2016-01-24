From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [MMC question] make sure to receive mrq->data->sg_len == 1
Date: Mon, 25 Jan 2016 02:32:33 +0900
Message-ID: <CAK7LNAR0QZN72SmTGx8OtAgJ-Ju4MV_oXGsaD01BKsqNOiDedA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi.


I am tackling on an MMC host controller driver for the first time.
Forgive my newbie question.


The DMA engine on my MMC host is so simple
that it can only handle one physically contiguous region
during one CMD18/CMD25 sequence.


In other words, it would be very troublesome for the driver
to receive two scatter-list entries or more.
(mrq->data->sg_len > 1).


I have not deeply dived into the MMC subsystem,
but my first guess is that "max_segs" and "max_seg_size"
are related parameters for controlling the
number of the entries and total size of the scatter-list,
respectively.
Is this correct?



-- 
Best Regards
Masahiro Yamada
