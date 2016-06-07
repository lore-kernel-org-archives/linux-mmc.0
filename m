From: Michal Kadlic <michal.kadlic@spinet.sk>
Subject: Re: mmc-moxart: CMD6 locks up the controller
Date: Tue, 7 Jun 2016 10:39:54 +0200
Message-ID: <c01db803-6a52-51c1-78e0-50cff4ce488c@spinet.sk>
References: <298c9ee5-37c7-6120-196d-860ec8eb0f9c@spinet.sk>
 <CAPDyKFrFzGZpO1SQwpCUJOZAD3izPgubAmhhWDxeO+jETQgvgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.spinet.sk ([212.89.230.194]:46944 "EHLO mail.spinet.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbcFGIkB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Jun 2016 04:40:01 -0400
In-Reply-To: <CAPDyKFrFzGZpO1SQwpCUJOZAD3izPgubAmhhWDxeO+jETQgvgQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jonas Jensen <jonas.jensen@gmail.com>

On 3. 6. 2016 10:49, Ulf Hansson wrote:
> On 1 June 2016 at 15:10, Michal Kadlic <michal.kadlic@spinet.sk> wrote:
>> Hello,
>>
>> newbie here, please bear with me...
>>
>> It seems that CMD6/SD_SWITCH request locks up the mmc-moxart controller. It
>> does not respond to any command after CMD6.
>> The fix suggested by Mr. Jonas Jensen <jonas.jensen@gmail.com>  is to ignore
>> the SD_SWITCH request in moxart_request()
>> My question is - looking at mmc_read_switch() in drivers/mmc/core/sd.c -
>> would be -EINVAL a proper response in this case?
> No, this seems like a bad solution to the problem.
>
> If the SD_SWITCH command isn't working, then it's better to find out
> *why* instead of only disable it. That's because it would mean to also
> disable all higher speed modes for the cards.
>
> BTW, under what circumstances does the lock up happens? In all cases
> when trying to detect an inserted card?
>
> Kind regards
> Uffe
>
It seems that the lockup happens no matter what mode 0 query is sent to 
the controller.
I found a bug that sets APP_CMD flag even on regular commands , which 
did affect CMD6, but fixing the bug did not fix CMD6.
I will try to repeat the lockup with different SD card, but so far the 
sequence that leads up to this lockup is following:

[   62.270000] mmc0: starting CMD0 arg 00000000 flags 000000c0
[   62.280000] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[   62.290000] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 23 
width 0 timing 0
[   62.310000] mmc0: starting CMD8 arg 000001aa flags 000002f5
[   62.310000] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
[   62.320000] mmc0: starting CMD55 arg 00000000 flags 000000f5
[   62.330000] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 
00000000
[   62.340000] mmc0: starting CMD41 arg 40800000 flags 000000e1
[   62.340000] moxart-mmc: Sending command with APP_CMD_flag
[   62.350000] mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 
00000000
[   62.380000] mmc0: starting CMD55 arg 00000000 flags 000000f5
[   62.380000] mmc0: req done (CMD55): 0: 00000120 00000000 00000000 
00000000
[   62.390000] mmc0: starting CMD41 arg 40800000 flags 000000e1
[   62.400000] moxart-mmc: Sending command with APP_CMD_flag
[   62.400000] mmc0: req done (CMD41): 0: c0ff8000 00000000 00000000 
00000000
[   62.420000] mmc0: starting CMD2 arg 00000000 flags 00000067
[   62.420000] mmc0: req done (CMD2): 0: 1d414453 44202020 02b01154 0100e9fb
[   62.430000] mmc0: starting CMD3 arg 00000000 flags 00000075
[   62.440000] mmc0: req done (CMD3): 0: 59b40520 00000000 00000000 00000000
[   62.450000] mmc0: starting CMD9 arg 59b40000 flags 00000007
[   62.460000] mmc0: req done (CMD9): 0: 400e0032 5b590000 39bd7f80 0a400045
[   62.460000] mmc0: starting CMD7 arg 59b40000 flags 00000015
[   62.470000] mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
[   62.480000] mmc0: starting CMD55 arg 59b40000 flags 00000095
[   62.490000] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 
00000000
[   62.500000] mmc0: starting CMD51 arg 00000000 flags 000000b5
[   62.500000] mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
[   62.520000] moxart-mmc: Sending command with APP_CMD_flag
[   62.520000] mmc0: req done (CMD51): 0: 00000920 00000000 00000000 
00000000
[   62.530000] mmc0:     8 bytes transferred: 0
[   62.540000] mmc0: starting CMD55 arg 59b40000 flags 00000095
[   62.540000] mmc0: req done (CMD55): 0: 00000920 00000000 00000000 
00000000
[   62.560000] mmc0: starting CMD13 arg 00000000 flags 000001b5
[   62.560000] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
[   62.570000] moxart-mmc: Sending command with APP_CMD_flag
[   62.580000] mmc0: req done (CMD13): 0: 00000920 00000000 00000000 
00000000
[   62.590000] mmc0:     64 bytes transferred: 0
[   62.590000] mmc0: starting CMD6 arg 00fffff0 flags 000000b5
[   62.600000] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
[   63.610000] mmc-moxart 98e00000.mmc: timed out waiting for status
[   66.350000] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[   66.350000] mmc0:     64 bytes transferred: -110
[   66.360000] mmc0: error -110 whilst initialising SD card
